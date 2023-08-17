Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA27677FD2F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 19:44:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354074AbjHQRoT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 13:44:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354110AbjHQRn7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 13:43:59 -0400
Received: from s1.sapience.com (s1.sapience.com [72.84.236.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C015630F0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 10:43:56 -0700 (PDT)
Authentication-Results: dkim-srvy7; dkim=pass (Good ed25519-sha256 
   signature) header.d=sapience.com header.i=@sapience.com 
   header.a=ed25519-sha256; dkim=pass (Good 2048 bit rsa-sha256 signature) 
   header.d=sapience.com header.i=@sapience.com header.a=rsa-sha256
Received: from srv8.prv.sapience.com (srv8.prv.sapience.com [x.x.x.x])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
        (No client certificate requested)
        by s1.sapience.com (Postfix) with ESMTPS id B9218480AD0;
        Thu, 17 Aug 2023 13:43:55 -0400 (EDT)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=sapience.com;
 i=@sapience.com; q=dns/txt; s=dk-ed25519-220413; t=1692294235;
 h=message-id : date : mime-version : subject : to : cc : references :
 from : in-reply-to : content-type : content-transfer-encoding : from;
 bh=pchJGXdFj7yASFJiMjwy7GapHCrWKXFQX/m1Yk4JjY8=;
 b=iZMIp8y252HjvqY6H8pTAcdcmVE8Ztwrcowqloe9H4Y9bEtTQ5/+s/dgHNlc2dl9wXGrj
 EQDd8nYvSX9CE+zCQ==
ARC-Seal: i=1; a=rsa-sha256; d=sapience.com; s=arc6-rsa-220412; t=1692294235;
        cv=none; b=oHMtZajJ+RDIMnuZSmccYVweMEpqCAsK1AyWYT55DedirrsA4BBLr9Jb1Yqwde6orRhaQh2lfkVpo0a5UQwLrVUb6mVKttUL4TYObkWS2ZQen3l0RtbkaXnLfzyzKW8FVSAHXZ2oGWxdn84+AvOySw8+80dXxTuoSqplKke7trbR4rYmJgAXvpwYkv1dMtyvuE/7zCn40hHFYLpjZV2Bn362hQ4sLZWvU5mKMnGCy6P1xLtXJ4RBrmhUJ3AxWHBPzVB2n+bjeIhN2p/R6PaqjpUiCKJa29pCtJ3DYAXOJj/Zi7mDJVL4q9Q3tnYwEJLQSOCjitw9jNzDUdPha0kCRg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=sapience.com; s=arc6-rsa-220412;
        t=1692294235; c=relaxed/simple;
        bh=dZS5RVSYcsGorR4/8gqqGJDeqMoexXOT4YAtAxwqxfI=;
        h=DKIM-Signature:DKIM-Signature:Message-ID:Date:MIME-Version:
         User-Agent:Subject:Content-Language:To:Cc:References:From:
         In-Reply-To:Content-Type:Content-Transfer-Encoding; b=F71VhLZz9OqoTV0r670h5mTEPDqhw61ieXOq2XGqxYV27K0sxBkbWKXftHuy8SAWmW8YUlveuj3pUavsVLpcWxKSoD1bR84ejDiRRyFcUoEE6cn0Rxg/weIDcXN2hLEvnxZNquhC2Vz7BzIjbO7Bjale1HzRQDPkYmAIrmtzIyc06BlYPb6NGkn/tVUjhoOEGOVconvN+ulWgLOkYPpt8AS5j7FxzZmkJia+VEAUFKILk43NsWBgz+iREly/DD+LyQSoYkCgA/JzrfzMhQl7J6LQyBc09zjCb7eC+wO7TGIXxP6xlwpFtzIU70NBRWzn4jINJUT41f0MPq7AMFi5og==
ARC-Authentication-Results: i=1; arc-srv8.sapience.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sapience.com;
 i=@sapience.com; q=dns/txt; s=dk-rsa-220413; t=1692294235;
 h=message-id : date : mime-version : subject : to : cc : references :
 from : in-reply-to : content-type : content-transfer-encoding : from;
 bh=pchJGXdFj7yASFJiMjwy7GapHCrWKXFQX/m1Yk4JjY8=;
 b=X2OrGUVueTaxda7MdDQqGWuspU2C/glVS/gWDL1xf3O3kk9A+nFlqKLOciuL0XitFyUWS
 QhtLQNqSLjJTHysxCVa7Uy/m/D4yiC6KXXmrW8SXzS9BgYjHe3aBFyMBhzAaUQHJP3vuQGh
 bgm2Vm5jzfhy6zbmO3/jCGj+f8wOirCOFI8nU7AU9nCxqkzG1nYEWPvWyWfd9sCcL690DLB
 SrKxgcRMZzid3BasnXdGYFsaE55ZQgo+uSgo7RGwmiNHgVsDkmTxm6os7mi0lPj6yhBLCgI
 a1XQ1MPGBJHla4NeJTFkIumoDYxv106jro6hvw6DBpJaT3crwrCjocQZlLLQ==
Message-ID: <144d4c08-2cd4-4d77-acb5-5c89d8dede46@sapience.com>
Date:   Thu, 17 Aug 2023 13:43:55 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Possible nvme regression in 6.4.11
Content-Language: en-US
To:     Keith Busch <kbusch@kernel.org>
Cc:     linux-kernel@vger.kernel.org, axboe@kernel.dk, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, hch@lst.de, arnd@arndb.de,
        ricky_wu@realtek.com, gregkh@linuxfoundation.org
References: <5f968b95-6b1c-4d6f-aac7-5d54f66834a8@sapience.com>
 <ZN050TFnKZ54LJ5v@kbusch-mbp.dhcp.thefacebook.com>
 <30b69186-5a6e-4f53-b24c-2221926fc3b4@sapience.com>
 <570d465a-7500-4b58-98f0-fd781c8740cc@sapience.com>
 <ZN5YqPuT0+j8kP3l@kbusch-mbp.dhcp.thefacebook.com>
From:   Genes Lists <lists@sapience.com>
In-Reply-To: <ZN5YqPuT0+j8kP3l@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/17/23 13:28, Keith Busch wrote:
...
>>>
>>> Bisect done - This is result:
> 
> Sounds like the driver's ASPM suspicion was justified, however the
> recommended work-around doesn't appear to apply to this hardware.
> Thanks for running the bisect!

Happy to help :)

gene

