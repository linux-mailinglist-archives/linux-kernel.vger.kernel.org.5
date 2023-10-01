Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 266697B4682
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 11:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234708AbjJAJNn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 05:13:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234689AbjJAJNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 05:13:40 -0400
Received: from omta040.useast.a.cloudfilter.net (omta040.useast.a.cloudfilter.net [44.202.169.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 969E6C6;
        Sun,  1 Oct 2023 02:13:37 -0700 (PDT)
Received: from eig-obgw-6001a.ext.cloudfilter.net ([10.0.30.140])
        by cmsmtp with ESMTP
        id mekCql2REaLCxmsW8qyc9N; Sun, 01 Oct 2023 09:13:36 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTPS
        id msW7qkTG0JhbSmsW8qDH16; Sun, 01 Oct 2023 09:13:36 +0000
X-Authority-Analysis: v=2.4 cv=YMiMdDKx c=1 sm=1 tr=0 ts=65193840
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=P7XfKmiOJ4/qXqHZrN7ymg==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=bhdUkHdE2iEA:10 a=wYkD_t78qR0A:10 a=VwQbUJbxAAAA:8
 a=cm27Pg_UAAAA:8 a=2PcnruhlFBHVcXBBCtIA:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22 a=xmb-EsYY8bH0VWELuYED:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=MrAp7LCAcddLccSTimBB1XRn1y7D20vfA2wvqsAEa8A=; b=EoHYcehP85PCU9nMRzqsDqdbXN
        8d+lvBreBD+QwOo/0MbsJb0PIHlAL1FdA0keHt/b/yi5FqLhQ/vBAjLFpEDqAkFbQL3h4gKXGD6oA
        xyHL0phXFGgLFPab5dzhFd/F0wXsSWSjRrHAZazfXjHnSujTWKYOvdnKVFTKRChBCD/XkF1chsWWn
        uK68qN7dUyW9rbOmiWCVdgeh8CKddEeUaiGf4gBD4AyEZMrkTUqyWaC59zRlLCw7tCgX9hnTgBVl0
        /F5EaYbPiqaGTRjrbYQ1PpGM5fSnddYCfE+4wrA0oBqW/BOF2QC6Ry9jUqvIj/VN6vkU1vUo2PZFL
        CzDhd2PQ==;
Received: from [94.239.20.48] (port=44878 helo=[192.168.1.98])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96)
        (envelope-from <gustavo@embeddedor.com>)
        id 1qmqKb-001WQf-2I;
        Sun, 01 Oct 2023 01:53:33 -0500
Message-ID: <d044b556-d97f-218f-4282-5d87be6a8ef9@embeddedor.com>
Date:   Sun, 1 Oct 2023 08:53:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH][next] ALSA: 6fire: Fix undefined behavior bug in struct
 midi_runtime
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Torsten Schenk <torsten.schenk@zoho.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
References: <ZRb2CKHuaCu0u38i@work> <202309291026.06071AC@keescook>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <202309291026.06071AC@keescook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 94.239.20.48
X-Source-L: No
X-Exim-ID: 1qmqKb-001WQf-2I
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.98]) [94.239.20.48]:44878
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 0
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfGETayY3YbenZ+YY9kgXKowbvky8bh6mPiXMZHTytdz7IZpAdt1yaaVfMkDp7qdQgYT5M+PNY2B+WOw5UI9k3T0gZRZBw7uQvkzQ4F2bcP7BUMPzDiOo
 0VE+y4wHAljI7u4rekHXpjBTqxgq4P1MSfVDJ2WOG/4tVXwZQCDiqOGYUmgrjBGv9F3yO65rlNw7nk06Yr+19UZDao/943MsMsvfZOVEpIK0Q5yP02rZ2PzT
 xpwQ0hLtxrTyCsb0t5OpuLiDJOlhuFsjSU8bg7XtJiI=
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/29/23 19:27, Kees Cook wrote:
> On Fri, Sep 29, 2023 at 06:06:32PM +0200, Gustavo A. R. Silva wrote:
>> `struct urb` is a flexible structure, which means that it contains a
>> flexible-array member at the bottom. This could potentially lead to an
>> overwrite of the objects following `out_urb` in `struct midi_runtime`,
>> among them a function pointer.
>>
>> Fix this by placing the declaration of object `out_urb` at the end of
>> `struct midi_runtime`.
>>
>> Fixes: c6d43ba816d1 ("ALSA: usb/6fire - Driver for TerraTec DMX 6Fire USB")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> 
> Another good find. :)

There are more coming. :)

> 
> Reviewed-by: Kees Cook <keescook@chromium.org>
> 

Thanks!
--
Gustavo
