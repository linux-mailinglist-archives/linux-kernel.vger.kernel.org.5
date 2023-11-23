Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9DC17F63E5
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 17:26:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbjKWQ0X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 11:26:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjKWQ0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 11:26:22 -0500
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B90FD19D
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 08:26:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Xh7Y/mSBPq7BLBwAU3A4AIcxfgYXsUCEs3Q4NfhjiA0=; b=j0/hfm0yHCf3fHv4qsat0HpZ8x
        0Py1vSmAUI3fdvMSLugeAxDOKJl2uoEUpCULBe2RyIoDfojyym1DZ7UneY7FeuOTOYYnHIWu+uz0Q
        bA32W0qOvSyb9EAKHAd5X7wZpEEMl2X69dqYsCc66oAh39tSZE9F6qBD2xptcHx2d+If75GT1ei+A
        bzjXOSdDrthlzMFRkHLDMiPUgXl7cwv8wyYv/GdJ4gi+b2XAMurzlvio8C/ZuBYIa4GLI40V3DDvN
        /GAvR+X8PhWjXmswA1GjbVHE8tyrIAzo1ubSGT3innw6+oTCOSQppCDhSzJxLq77ctvYLPeMxtic5
        1z4C2IJQ==;
Received: from 189-69-166-209.dial-up.telesp.net.br ([189.69.166.209] helo=[192.168.1.111])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1r6CWq-006T2H-Pl; Thu, 23 Nov 2023 17:26:13 +0100
Message-ID: <a7ed1b78-da8e-4893-9143-000a4a0e4e11@igalia.com>
Date:   Thu, 23 Nov 2023 13:26:07 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 0/4] drm: Add support for atomic async page-flip
Content-Language: en-US
To:     Simon Ser <contact@emersion.fr>
Cc:     Hamza Mahfooz <hamza.mahfooz@amd.com>,
        pierre-eric.pelloux-prayer@amd.com,
        =?UTF-8?B?J01hcmVrIE9sxaHDoWsn?= <maraeo@gmail.com>,
        =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>,
        intel-gfx@lists.freedesktop.org,
        Randy Dunlap <rdunlap@infradead.org>, xaver.hugl@gmail.com,
        amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Pekka Paalanen <ppaalanen@gmail.com>,
        dri-devel@lists.freedesktop.org, kernel-dev@igalia.com,
        alexander.deucher@amd.com, christian.koenig@amd.com
References: <20231122161941.320564-1-andrealmeid@igalia.com>
 <cc10f6b0-e26e-4021-85ca-33cb1e58e937@amd.com>
 <50ff86d4-5ce1-4ae5-aafb-ce3bc0069629@igalia.com>
 <WG-nBy-xqSEAQQX1ASB9Gw7Ra0aZ-qFYDQq1mXjQdOTwxlM1wEROginNiWbnM9CZE9idUyE6P5urNZ8q8kFMswbPt5ewbk3ocuIVnajQpAQ=@emersion.fr>
From:   =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
In-Reply-To: <WG-nBy-xqSEAQQX1ASB9Gw7Ra0aZ-qFYDQq1mXjQdOTwxlM1wEROginNiWbnM9CZE9idUyE6P5urNZ8q8kFMswbPt5ewbk3ocuIVnajQpAQ=@emersion.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em 23/11/2023 13:24, Simon Ser escreveu:
> Thanks! This iteration of the first 3 patches LGTM, I've pushed them to
> drm-misc-next. I've made two adjustments to make checkpatch.pl happy:
> 

Thank you!

> - s/uint64_t/u64/
> - Fix indentation for a drm_dbg_atomic()

ops :)
