Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F4527F8D0B
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 19:22:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbjKYSSL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 13:18:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjKYSSK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 13:18:10 -0500
Received: from sender-of-o51.zoho.in (sender-of-o51.zoho.in [103.117.158.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 206E5C5;
        Sat, 25 Nov 2023 10:18:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1700936285; cv=none; 
        d=zohomail.in; s=zohoarc; 
        b=bas6VjemocG8TyCyF8HFuv/zFMao9cFMXTQ7t0cu/27MK9pCEqcIgQWVGbaR5MTM+PIyedsvn7M0bD4q5fyz2PVOhwQVnKQPDkeOqQrTg/QEYCqA1uU7CSIe4WagK7Wkbv7rnddP+fSDWhoSJe9NyQn/cpbw7SXcYzZlYtS5Sfo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
        t=1700936285; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
        bh=fBDLnuxTYKM5FtsGLDrQ8Mws1yikp+Htr0jXUnTb6CU=; 
        b=QqLhrmTpThjCTY1ScEMFhXmcoEWOeOodX2HzDuHHsttvLIqb9nrN6jDDdYkU5laZNn3XRj16F6u3f7WgwpznP6qlT4sU6ne/Klflq9wkJcr2rYkXTvDT1bA3HhuetLGzT32TdjfR6yMMCSbAATgDIZqMNVfVlwLg6ng/GI5FEK4=
ARC-Authentication-Results: i=1; mx.zohomail.in;
        dkim=pass  header.i=siddh.me;
        spf=pass  smtp.mailfrom=code@siddh.me;
        dmarc=pass header.from=<code@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1700936285;
        s=zmail; d=siddh.me; i=code@siddh.me;
        h=Message-ID:Date:Date:MIME-Version:To:To:Cc:Cc:References:Subject:Subject:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=fBDLnuxTYKM5FtsGLDrQ8Mws1yikp+Htr0jXUnTb6CU=;
        b=nuW/XJFoL919srMjhZpfoKnhrZq7X7FZ3zg4Bj8zRsNoar9N47yt79+jjIpv8DP5
        cG+3nGvo++rwe7EX/54f5iQMP8o9nCt/pQeHwsQfmq4fTabghR0RMTxqWK4pOH9AsE1
        63ms1e8ZxrmCGzi7jjBipvUVJZbQ0YP11hlbT7gI=
Received: from [192.168.1.11] (110.226.61.26 [110.226.61.26]) by mx.zoho.in
        with SMTPS id 1700936284980449.10896378002474; Sat, 25 Nov 2023 23:48:04 +0530 (IST)
Message-ID: <f0c24608-a74a-40e3-a7b6-7dc7ca285a35@siddh.me>
Date:   Sat, 25 Nov 2023 23:48:02 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To:     syzbot+bbe84a4010eeea00982d@syzkaller.appspotmail.com
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
References: <0000000000005abf1f060afd76bd@google.com>
Subject: Re: [syzbot] [net?] [nfc?] KASAN: slab-use-after-free Read in
 nfc_alloc_send_skb
Content-Language: en-US, en-GB, hi-IN
From:   Siddh Raman Pant <code@siddh.me>
In-Reply-To: <0000000000005abf1f060afd76bd@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

#syz test https://github.com/siddhpant/linux.git lock
