Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB74A7DE13F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 14:05:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343762AbjKAMvN convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 1 Nov 2023 08:51:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231485AbjKAMvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 08:51:11 -0400
X-Greylist: delayed 907 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 01 Nov 2023 05:51:04 PDT
Received: from sender11-of-o51.zoho.eu (sender11-of-o51.zoho.eu [31.186.226.237])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08E6EB7
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 05:51:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1698842150; cv=none; 
        d=zohomail.eu; s=zohoarc; 
        b=Un61c349E0VZVnT+x+fMzpqsGysU3B9HdRSMNiCGD2eVKGpARbfitSE5LPTTWJix0kdgQLYWTeutPNRuFU9vfu6z6r053saU05jR6SM8AJthw9Yf0Z/Wd5gPgg0wYx89O4jVk7EUicfcgvKqRtDdPS3kYgHvi5a6w2rDaIf2Vk0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
        t=1698842150; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
        bh=Owj+mXdGILdMjrSzoqOSKr2JpK848tlEK4LY5T0/yoY=; 
        b=EIrhU6LOOHw2RPmrkWaN56lZkGt0NcqlS+4FBMnF4cZeD2NtFp9r2GpA4iKJ0PFXpJ9jUDOJ14vN2z1xHUKWIepGI0Bu0IBAuiPH5QAy2G2VZTAnwquCEwjr6IE1PZR57PjpPs85V6Nvj6Al47AQ43tXo0qR73kGYlTA6jsgKDo=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
        spf=pass  smtp.mailfrom=carl@uvos.xyz;
        dmarc=pass header.from=<carl@uvos.xyz>
Received: from [10.0.0.2] (ip-037-201-241-037.um10.pools.vodafone-ip.de [37.201.241.37]) by mx.zoho.eu
        with SMTPS id 169884214814494.9572778770256; Wed, 1 Nov 2023 13:35:48 +0100 (CET)
Message-ID: <47e950989fe0fc297a2272139d69a5a7c4c98de5.camel@uvos.xyz>
Subject: [BUG] gpu: drm: amd: noretry=0 causes failure in
 amdgpu_device_ip_resume on vega10
From:   Carl Klemm <carl@uvos.xyz>
To:     christian.koenig@amd.com, alexander.deucher@amd.com
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Date:   Wed, 01 Nov 2023 13:35:47 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.4 
MIME-Version: 1.0
X-ZohoMailClient: External
X-Spam-Status: No, score=-0.0 required=5.0 tests=BAYES_20,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

When migrateing from 5.15 to 6.5.9 i noticed that noretry no longer
function on vega10 (Instinct MI25). The device will fail to start:

[   40.080411] amdgpu: fw load failed
[   40.083816] amdgpu: smu firmware loading failed
[   40.088350] amdgpu 0000:83:00.0: amdgpu: amdgpu_device_ip_resume
failed (-22).

I have also repoduced the same issue on 6.1.55
It is also possible that the issue was caused by newer gpu firmware,
instead of the change in kernel. The issue was repduced with the
firmware from linux-firmware-20230804.

for full dmesg see: https://uvos.xyz/noretry.dmesg.log

The same system also contains 2 vega20 and 1 navi21 device that both
work fine with noretry=0. For more information on the system this
problem was encountered on see this rocminfo dump:
https://uvos.xyz/rocminfo.log

Regards,
Carl
