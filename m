Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD520786CAB
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 12:22:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238650AbjHXKWY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 06:22:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234132AbjHXKWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 06:22:23 -0400
Received: from s1.sapience.com (s1.sapience.com [72.84.236.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4A591739
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 03:22:20 -0700 (PDT)
Authentication-Results: dkim-srvy7; dkim=pass (Good ed25519-sha256 
   signature) header.d=sapience.com header.i=@sapience.com 
   header.a=ed25519-sha256; dkim=pass (Good 2048 bit rsa-sha256 signature) 
   header.d=sapience.com header.i=@sapience.com header.a=rsa-sha256
Received: from srv8.prv.sapience.com (srv8.prv.sapience.com [x.x.x.x])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
        (No client certificate requested)
        by s1.sapience.com (Postfix) with ESMTPS id 30FA8480317;
        Thu, 24 Aug 2023 06:22:20 -0400 (EDT)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=sapience.com;
 i=@sapience.com; q=dns/txt; s=dk-ed25519-220413; t=1692872540;
 h=message-id : date : mime-version : subject : from : to : cc :
 references : in-reply-to : content-type : content-transfer-encoding :
 from; bh=KufHLa8qiX8ZvrwLb6e3dfBbke9UjLL2TqS8CHx6Fag=;
 b=1qQYwQ6WLssz/XOM/10YpPb7P43nXmZ86V2Hf2si7303Zg3gmKw1xhdsZRO8RQOH5NKdl
 5DPVAk7n5QoP8ImAw==
ARC-Seal: i=1; a=rsa-sha256; d=sapience.com; s=arc6-rsa-220412; t=1692872540;
        cv=none; b=HyriQ/wyihUGWTCNjEJ6ODyaqhTWeHDqbrz1HkCCanFvJuWQQ3YHAGTL70g97Wg7O4ew/ATgmv8x+Rcfw+WkKfTFn0xmDqmVsRzA6KnDVWnithrzfolm9ZHYca9xrVtYAo9YDFsVsBIJhprQ60L9L7JvWCsamlobI/DZwthEtsPlWzxfJd2lp+xIOZwmd0G8RGzMH2exuWyQWBaJUbT/HN6TyNqYJVImRnnAFoK6I9Sc0RBp8AIr7fwiS69yEHatrCgzHENkmiL51Uf93riTSh5bQ9Itq0qyhrbR32g/cD/6oFSO3NHZ1y+4cOzqpBLZi1u6/ux0ZdL7FCHkgzePtA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=sapience.com; s=arc6-rsa-220412;
        t=1692872540; c=relaxed/simple;
        bh=Zpsq7U/BuRxBt/NCOP9yDwQsPGzsVD3b8KgcZUs6cX8=;
        h=DKIM-Signature:DKIM-Signature:Message-ID:Date:MIME-Version:
         User-Agent:Subject:Content-Language:From:To:Cc:References:
         In-Reply-To:Content-Type:Content-Transfer-Encoding; b=HSd3D/WcEYM7qPD9Xrrwol2fh9z0KjRxXpisetTjCVmKy7S+qDeY6K8CeblBoanFfZtWYEt0ooUd+YgePxrthHbRQGkxbJsB4DT/zpg6UZ/qQgtOYXgnsO6BTOMjOde8L++haovBxSGfWRxYQCrSGwvXQlg6xTMKsct/6SzkoA8it04n5wUGqJaMMtubczgUtZm1+H0vj2lZAgYs7wSaCIIXpo+M7FH3h/dPhsgSI7pndO57I3tRzV96Fgg1ne6clpw7vqWtEYns11yXTGf8qhXJtHy/Urb9CIAlqFrtCPSgmrfwV+hKQLPTsCst1GQKzIZHIU1bSl3pERFsF3kGiQ==
ARC-Authentication-Results: i=1; arc-srv8.sapience.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sapience.com;
 i=@sapience.com; q=dns/txt; s=dk-rsa-220413; t=1692872540;
 h=message-id : date : mime-version : subject : from : to : cc :
 references : in-reply-to : content-type : content-transfer-encoding :
 from; bh=KufHLa8qiX8ZvrwLb6e3dfBbke9UjLL2TqS8CHx6Fag=;
 b=l1X4u/6uzfeTakw7gS+qbyCDNYciUcqr1vAVoukJ5/H+y6wrXqJXqJNhXVbNjKZOpYbaa
 596QDhRqYpdIvkhDTcHvOlnfFqo/fob3iR4nWNxDFvtGllRodO/jBh8fx5bpsBizIAZdC97
 udiABNMVUflV52kCHOmvjXJOjQ3/b1eSXWobisA8x5oJXOd0K10nkW8jD0IaT3S+2Lg9+S1
 TrLA1dqjTvNMrqEjZtE3Qivt7vlV0kD+u9bkChvuGLdMv4Ewl5Qw4c9OsbJ3ALU2sOMWiB0
 48lX5ANlVTeqn5Rq+yglYcu4eiFTFegg1VN/jwkMXdS3MuoqmdmUG/E/Obzg==
Message-ID: <97cee217-e438-4fff-836a-186f59d6d256@sapience.com>
Date:   Thu, 24 Aug 2023 06:22:19 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Possible nvme regression in 6.4.11
Content-Language: en-US
From:   Genes Lists <lists@sapience.com>
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
 <903830f8-9f9a-4071-9ced-761a55018c5a@sapience.com>
In-Reply-To: <903830f8-9f9a-4071-9ced-761a55018c5a@sapience.com>
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

On 8/24/23 05:48, Genes Lists wrote:
> On 8/23/23 22:44, Ricky WU wrote:
>> Hi Gene,
>>
>> I can't reproduce this issue on my side...
>>
>> So if you only revert this patch 
>> (69304c8d285b77c9a56d68f5ddb2558f27abf406) can work fine?
>> This patch only do is pull our clock request to HIGH if HOST need also 
>> can pull to LOW, and this only do on our device
>> I don’t think this will affect other ports...
>>
>> BR,
>> Ricky
> 
> Thanks Ricky - I will test revering just that commit and report back.  I 
> wont be able to get to it till later today (sometime after 2pm EDT) but 
> I will do it today.
> 
> FYI, i see one mpre report of someone experiencing same problem [1]
> 
> gene
> 
>   [1] https://bugs.archlinux.org/task/79439
> 
> 

That commit was what was reverted in the last step of the git bisect - 
and indeed reverting that commit makes the problem go away and machine 
then boots fine.

thanks

gene


