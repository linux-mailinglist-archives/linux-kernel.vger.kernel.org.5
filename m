Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60556783B8A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 10:16:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233736AbjHVIP7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 04:15:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231561AbjHVIPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 04:15:55 -0400
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 805D0193
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 01:15:52 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 6CB20240103
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 10:15:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1692692150; bh=bbcPDUec3n8Mcda4pzNw15dJ7yKMIkafcsVxYBD+uMY=;
        h=Message-ID:Subject:From:To:Date:Content-Transfer-Encoding:
         MIME-Version:From;
        b=R9lWbRZGGMS4l7y2bLpOQ1acSKV3pv2sb7Api8HupgHagpgioyVx86ub802EXrUMl
         y8fHi7M6aQPcrrhsUrrr7W6PMDs371GH30TcZ1LMVUqC5gQ/wllauVKTnbEPDVdpbs
         q1CqKA0QNL/iag7wB/lxQvH075auurm18k2VUJo711mqsIh2zt2XZp4SDleFmigH02
         eh4YBRNInhGI9MMXvyGnSjnnmags0Ab7pLZK3sOMRUYVEDdYv7HDbX3DhcpOsD8zSH
         yw20KYhnId7RfszzBilMcCGudb8ORdhStQoIm3mL1sQVyYs7qX7nXBqScdCd9ab4zy
         dZat5gjwama4Q==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4RVMc60qByz6tx1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 10:15:50 +0200 (CEST)
Message-ID: <38b2af4a43df2c6323c747d690ae6b713afa3cb8.camel@posteo.de>
Subject: [iwlwifi] - problems with device list loop and Intel Killer AX1650
 cards
From:   Michael Lugmair <michael.lugmair@posteo.de>
To:     linux-kernel@vger.kernel.org
Date:   Tue, 22 Aug 2023 08:15:49 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I am currently debugging why my Intel Killer AX1650 card is visible as
Intel AX203 in dmesg. This might be related to a problem that possibly
the wrong ucode is loaded.

[    1.849586] iwlwifi 0000:00:14.3: loaded firmware version
66.f1c864e0.0 QuZ-a0-hr-b0-66.ucode op_mode iwlmvm
[    2.092309] iwlwifi 0000:00:14.3: Detected Intel(R) Wi-Fi 6 AX203,
REV=3D0x354


With some debug output added to `drv.c`, I found out that my card is
actually {0x43F0, 0x1651} (this one here [1]). But this block is not
even considered when looking for the correct card.

IWL_DEV_INFO(0x43F0, 0x1651, killer1650s_2ax_cfg_qu_b0_hr_b0,
iwl_ax201_killer_1650s_name)


Instead, the following block is chosen for my card [2]:
_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
  IWL_CFG_MAC_TYPE_QUZ, SILICON_B_STEP,
  IWL_CFG_RF_TYPE_HR2, IWL_CFG_ANY, IWL_CFG_ANY,
  IWL_CFG_NO_160, IWL_CFG_ANY, IWL_CFG_NO_CDB,
  IWL_CFG_ANY,iwl_cfg_quz_a0_hr_b0, iwl_ax203_name)


The reason is that we are running backwards through the list of device
info blocks [3]. This leads to the behavior that we prefer the generic
entries over the specific ones. Generic entries have IWL_CFG_ANY for
device id and subdevice id. The specific ones have a dedicated number.

There was a refactoring once [4]. Before the refactoring we went
forward through the list. If a matching entry was found, we continued
to look for a "better" (more generic) entry instead of calling break,
so basically same behavior.

I can hardly believe that this is intended behavior. Can somebody
explain that to me?

Thanks in advance.

Best regards
Michael

[1]
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/drive=
rs/net/wireless/intel/iwlwifi/pcie/drv.c?h=3Dlinux-6.4.y#n570
[2]
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/drive=
rs/net/wireless/intel/iwlwifi/pcie/drv.c?h=3Dlinux-6.4.y#n1001
[3]
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/drive=
rs/net/wireless/intel/iwlwifi/pcie/drv.c?h=3Dlinux-6.4.y#n1538
[4]
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/dri=
vers/net/wireless/intel/iwlwifi/pcie/drv.c?h=3Dv6.4.9&id=3D0a1f96d571c841b3=
1d12d3697f149ae1ea3087ea
