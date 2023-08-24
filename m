Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 758E4786C45
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 11:49:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238775AbjHXJs2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 05:48:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240824AbjHXJsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 05:48:23 -0400
Received: from s1.sapience.com (s1.sapience.com [72.84.236.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F18DA10C7
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 02:48:21 -0700 (PDT)
Authentication-Results: dkim-srvy7; dkim=pass (Good ed25519-sha256 
   signature) header.d=sapience.com header.i=@sapience.com 
   header.a=ed25519-sha256; dkim=pass (Good 2048 bit rsa-sha256 signature) 
   header.d=sapience.com header.i=@sapience.com header.a=rsa-sha256
Received: from srv8.prv.sapience.com (srv8.prv.sapience.com [x.x.x.x])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
        (No client certificate requested)
        by s1.sapience.com (Postfix) with ESMTPS id 33C18480AD7;
        Thu, 24 Aug 2023 05:48:21 -0400 (EDT)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=sapience.com;
 i=@sapience.com; q=dns/txt; s=dk-ed25519-220413; t=1692870501;
 h=message-id : date : mime-version : subject : to : cc : references :
 from : in-reply-to : content-type : content-transfer-encoding : from;
 bh=DH+2hxPtncvNxefGoVKSbMNn+tUkPE31WVZ7cQnz3uM=;
 b=elXfSiHKv+C9D0FuyBc7c4iEIMwFkXo5xHhmFfPuhFwOb+uJKDR2+LYosPnHKYZgQ08Fb
 ddnxTr+J+0GX03RAQ==
ARC-Seal: i=1; a=rsa-sha256; d=sapience.com; s=arc6-rsa-220412; t=1692870501;
        cv=none; b=SZpail3ei3u0Nj3lfSfttHYH8ahVk1ZJuHQP0Q//kOz/lT3FwWGGdFrQ30+CB78sjy72dk4BhkjyYPpa+xLfFyYi9cr1KOJIOtBylnYtjU8DwujzhXHf8sfeQaoD0hvVvbguf2aBh4hjgX1ivYXH4XhqRGlvLso7looigZQcafGXtVitDe7cZdEvT2AfTIxWJ9juYXxjESw6ZQw67eL/YkjaZwIPpV3k7Agrfupw8K5nk7M7TZ5dkvVfYIySiY1d3eaWOuz2i1mGzcjAF1jShaBzlmd00hCVcYa3amDXfZMWFObDK3aUbGloELQaFnreNg7JbY8lV2cumxLHPGu7UA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=sapience.com; s=arc6-rsa-220412;
        t=1692870501; c=relaxed/simple;
        bh=Zaj1r2D/y9d6w3HtH46woGegOcwHSMooJRyRFEO2cBU=;
        h=DKIM-Signature:DKIM-Signature:Message-ID:Date:MIME-Version:
         User-Agent:Subject:Content-Language:To:Cc:References:From:
         In-Reply-To:Content-Type:Content-Transfer-Encoding; b=agmVIBlWB1zpRPX/6cz/KUX6gq8IDc21uNFGLwaxv6VwZKpLNJXEFjpAGj98l1B02YqNY6bmwK7BnVExTedVZSVX0EyAqdG5++C7Sg75TN1XrB2AUdalm5r5Eon+rZOI7L7uHoRgCt6WNDeYyVoghAkKa7IzK9iXCLfi+oRkSkjkXbijBDrZgGqSBHqzMBRbufse1dTvhH9UeAuLiD+s0dCvHfrwr3S4vRGfAly44c9UUj4pZNCBNsNiWOzoK8RJQzxx1og6LRdYsEFRqLHVNugio2FArRP+aQgWzfwuy04w4+bWBf/MHi+mX5ObqDdlHiCxSdvSZJzLSgJKShBfKQ==
ARC-Authentication-Results: i=1; arc-srv8.sapience.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sapience.com;
 i=@sapience.com; q=dns/txt; s=dk-rsa-220413; t=1692870501;
 h=message-id : date : mime-version : subject : to : cc : references :
 from : in-reply-to : content-type : content-transfer-encoding : from;
 bh=DH+2hxPtncvNxefGoVKSbMNn+tUkPE31WVZ7cQnz3uM=;
 b=P3HtSFYvDtEkexs5noFljLJ/gp2UQS3pOnCATCOJsAdlk12H3Vydh4CWQCZITbe6yLN0q
 Hr6/1/o+h+OxVHFFKIJ/paNUgyEhPZ/YMyLPomY+wuw0kU4af9Z03xt+UJ07OI+VwRhnbou
 TSG3UrmAp6UyZBooCd+QmhszKng994MAqVenHwL9Os9CSPn8boPOlj3MgKTFidwDSlpT/Jz
 UiaURf/N+Ra6ujozpUq0SpXgqKy42r5GMSjuFwA3fFf44oK6lR4CiOg9zZ8d2zFkSV6U7L/
 s7K0BekI23PORNUyLJjRCODEW94WiK60aisPGuxUGNUIdgIcdE5LtkqMH0qg==
Message-ID: <903830f8-9f9a-4071-9ced-761a55018c5a@sapience.com>
Date:   Thu, 24 Aug 2023 05:48:20 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Possible nvme regression in 6.4.11
Content-Language: en-US
To:     Ricky WU <ricky_wu@realtek.com>, Keith Busch <kbusch@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "hch@lst.de" <hch@lst.de>, "arnd@arndb.de" <arnd@arndb.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
References: <5f968b95-6b1c-4d6f-aac7-5d54f66834a8@sapience.com>
 <ZN050TFnKZ54LJ5v@kbusch-mbp.dhcp.thefacebook.com>
 <30b69186-5a6e-4f53-b24c-2221926fc3b4@sapience.com>
 <570d465a-7500-4b58-98f0-fd781c8740cc@sapience.com>
 <ZOZEwafA8+tknJNT@kbusch-mbp.dhcp.thefacebook.com>
 <7cf188d0-77b4-4e80-8da6-2045a7f29866@sapience.com>
 <180a2bbd2c314ede8f6c4c16cc4603bf@realtek.com>
From:   Genes Lists <lists@sapience.com>
In-Reply-To: <180a2bbd2c314ede8f6c4c16cc4603bf@realtek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/23/23 22:44, Ricky WU wrote:
> Hi Gene,
> 
> I can't reproduce this issue on my side...
> 
> So if you only revert this patch (69304c8d285b77c9a56d68f5ddb2558f27abf406) can work fine?
> This patch only do is pull our clock request to HIGH if HOST need also can pull to LOW, and this only do on our device
> I don’t think this will affect other ports...
> 
> BR,
> Ricky

Thanks Ricky - I will test revering just that commit and report back.  I 
wont be able to get to it till later today (sometime after 2pm EDT) but 
I will do it today.

FYI, i see one mpre report of someone experiencing same problem [1]

gene

  [1] https://bugs.archlinux.org/task/79439


