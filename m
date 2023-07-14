Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 489817543D2
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 22:36:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236229AbjGNUgu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 16:36:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233301AbjGNUgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 16:36:49 -0400
X-Greylist: delayed 491 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 14 Jul 2023 13:36:46 PDT
Received: from mx3.securetransport.de (mx3.securetransport.de [IPv6:2a01:4f8:c0c:92be::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A3E935B0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 13:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
        s=dhelectronicscom; t=1689366471;
        bh=WLMCrosg23DXiPiPkOztVSmq4YzunBfcMjZCfl0+bj0=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=nK3JEXrwY4xl+xKB2ICbxfAsPKXaIAvTCwIcYM0B8jU5R5iizg2jrH3A0NlK9IIOT
         NNPBvXa0D/A9FDumiPL/cehdumR9oynh3WjLYhDjM8q90+9NDS5/bw97ZVOEMTu+G0
         5dJ4jV0KR/af6wpnMkNU9c42Yo6Ho8nE+jKX6VRHWpVfKkBCDTdlttePP6U8DWb/jA
         K3Lduw1bfPzemVdOtAMgsm5a3J9gGgcmSU31xszSlgYGviUf2diMNieWsw9IIyvoiP
         3zg10CH5qxPL/xeL3eJ9QuGfEEDsg6Rluwwze4XJ0bZwEpAZoQ2KXwoWgYttQDd5Q7
         nsxmffVSUk1ZA==
X-secureTransport-forwarded: yes
From:   Christoph Niedermaier <cniedermaier@dh-electronics.com>
Complaints-To: abuse@cubewerk.de
To:     Mark Brown <broonie@kernel.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Support Opensource <support.opensource@diasemi.com>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Marek Vasut <marex@denx.de>,
        kernel <kernel@dh-electronics.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V5] regulator: da9062: Make the use of IRQ optional
Thread-Topic: [PATCH V5] regulator: da9062: Make the use of IRQ optional
Thread-Index: AQHZtWtRfWVqFQFEA06/3ZItgT3fA6+3fyIAgAA0IHCAABAkAIABu/qQgAADqgCAABCCYIAAAV0AgAACBKA=
Date:   Fri, 14 Jul 2023 20:27:45 +0000
Message-ID: <ef02362fdb5546e4962f1793659f2a54@dh-electronics.com>
References: <20230713090328.3879-1-cniedermaier@dh-electronics.com>
 <d8f60e51-2d62-4370-9032-51eda744239d@sirena.org.uk>
 <9629970cc2c3452e83a43660823319e5@dh-electronics.com>
 <8558f2aa-09fd-4cd3-ae1e-c80893e00aa1@sirena.org.uk>
 <c9759811145747f98462388f63358dd6@dh-electronics.com>
 <d80b10d3-7c4a-4430-8467-4672e3824a04@sirena.org.uk>
 <d7718a5bb2384bdd96a2cc612ae3640a@dh-electronics.com>
 <5f79c2c7-315b-409d-9f3d-78c1fb03bb49@sirena.org.uk>
In-Reply-To: <5f79c2c7-315b-409d-9f3d-78c1fb03bb49@sirena.org.uk>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mark Brown [mailto:broonie@kernel.org]
Sent: Friday, July 14, 2023 10:21 PM
> On Fri, Jul 14, 2023 at 08:15:40PM +0000, Christoph Niedermaier wrote:
>>> On Fri, Jul 14, 2023 at 07:03:28PM +0000, Christoph Niedermaier wrote:
>=20
>>> The ones quoted above.
>=20
>> The kernel test robot wrote:
>> [...]
>> If you fix the issue, kindly add following tag where applicable
>> | Reported-by: kernel test robot <lkp@intel.com>
>> | Link: https://lore.kernel.org/oe-kbuild-all/202303082246.GuLdPL0t-lkp@=
intel.com/
>> [...]
>=20
>> Maybe that misled me.
>=20
> Yes, I wish it wouldn't do that.  That really only applies when you're
> sending a patch that's substantially a fix for the issue it reports, for
> things that have not yet been applied it's just a normal review comment
> and you shouldn't add the tags.

Thank you for this clarification.

Regards
Christoph
