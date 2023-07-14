Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9343E753DE7
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 16:44:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236139AbjGNOoR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 10:44:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236138AbjGNOoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 10:44:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D57CB2D47
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 07:44:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 691EA61D30
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 14:44:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BF11C433C7;
        Fri, 14 Jul 2023 14:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689345849;
        bh=nrh+T+KV5cus0wCiIlcm1yIJsp6LqkHuZPVQemps+PI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=luLfcv7dDd4sCl6aA7hdlcj39vXUOSrsLZPuCuDu4SnHWVtxXjJOSHQNdCCyKuo/n
         aACkRIO9Cr2ckwK/7SK7DnRgirdFCIhP5xgnUuPMyXZk4y+y5VbtAsMKM4vQmYjoiy
         yGZRczQkqjlH3toVEoiJLQzxldHuugaKOXULdBQN4C0Zs3kFUNCzlv6eEEwMrD5aiZ
         U0vk9XM6Q/EKr90rFW3CSicY71YlrPut/WqERYT11BQGasSZLNekJW0mjCDrx401Mk
         oPLGiP6sxep/SbMjvk8BlMS5XNqwLhbJno+jIFWM7r0j8Huf6+rD/+iUoie0fvAcI/
         ADq9ziXd/jvDA==
Message-ID: <9cfa3708-908e-4689-faea-23ad4486485f@kernel.org>
Date:   Fri, 14 Jul 2023 09:44:08 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: =?UTF-8?B?UmU6IOWbnuWkjTog5Zue5aSNOiDlm57lpI06IFtQQVRDSF0gZmlybXdh?=
 =?UTF-8?Q?re=3a_stratix10-svc=3a_Fix_an_NULL_vs_IS=5fERR=28=29_bug_in_svc?=
 =?UTF-8?B?X2NyZWF0ZV9tZW1vcnlfcG9vbCgp?=
Content-Language: en-US
To:     =?UTF-8?B?546L5piOLei9r+S7tuW6leWxguaKgOacr+mDqA==?= 
        <machel@vivo.com>
Cc:     Dan Carpenter <dan.carpenter@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "opensource.kernel" <opensource.kernel@vivo.com>
References: <20230704082706.1721-1-machel@vivo.com>
 <fe780326-2150-a3e6-e451-ea82be65e0cf@web.de>
 <daa12e00-1d01-45d0-89c8-03ff94fa3399@kadam.mountain>
 <SG2PR06MB3743AC289C8C124CA57C77DABD2CA@SG2PR06MB3743.apcprd06.prod.outlook.com>
 <fe812000-c5bf-4510-a3a9-76684a59ecc9@kadam.mountain>
 <SG2PR06MB3743DD3C50017612CF3BE38ABD2CA@SG2PR06MB3743.apcprd06.prod.outlook.com>
 <2ca3892e-a018-37e1-5a3d-288e6af2ec4d@kernel.org>
 <SG2PR06MB3743994BB1C786B2BE4A24A7BD34A@SG2PR06MB3743.apcprd06.prod.outlook.com>
From:   Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <SG2PR06MB3743994BB1C786B2BE4A24A7BD34A@SG2PR06MB3743.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/14/23 04:46, 王明-软件底层技术部 wrote:
> Hi Dinh
> Excuse me, I don't know if your vacation is over. This is the patch I submitted before:
> https://lore.kernel.org/all/20230704082706.1721-1-machel@vivo.com/
> regards

There was a comment from Dan Carpenter about adding the Fixes tag. I was 
waiting the patch with that.

Dinh
