Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E6F978E186
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 23:38:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241809AbjH3Vi3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 17:38:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241759AbjH3Vi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 17:38:27 -0400
Received: from s1.sapience.com (s1.sapience.com [72.84.236.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA1A1CE6
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 14:37:55 -0700 (PDT)
Authentication-Results: dkim-srvy7; dkim=pass (Good ed25519-sha256 
   signature) header.d=sapience.com header.i=@sapience.com 
   header.a=ed25519-sha256; dkim=pass (Good 2048 bit rsa-sha256 signature) 
   header.d=sapience.com header.i=@sapience.com header.a=rsa-sha256
Received: from srv8.prv.sapience.com (srv8.prv.sapience.com [x.x.x.x])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
        (No client certificate requested)
        by s1.sapience.com (Postfix) with ESMTPS id D737B480A54;
        Wed, 30 Aug 2023 17:09:07 -0400 (EDT)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=sapience.com;
 i=@sapience.com; q=dns/txt; s=dk-ed25519-220413; t=1693429747;
 h=message-id : date : mime-version : subject : to : cc : references :
 from : in-reply-to : content-type : content-transfer-encoding : from;
 bh=JAQWYBmETROLjbPGuqGIMm8OdFb4xMwJG4FqWN0oL6A=;
 b=fM1Bq4eNemLcyRcbzAy8Q+wojExGbY8BB5+74Y2nwKJ4OgcBukkkb9FIMv9tSHxVQEwv1
 /4a14wBFfDk1PFLCg==
ARC-Seal: i=1; a=rsa-sha256; d=sapience.com; s=arc6-rsa-220412; t=1693429747;
        cv=none; b=u9x97SgH2/mzbicAoyiCc70vrsQgu/pwyoxQsqmlx0/8nG0fcff/msnPxzxrmVLbxO9dH1srLSXI1HT786DhmfTFOmKR3EhCQQ4Y5JdfPiBGKlfaO+bc9YSgKqcJP/VbUW+Ycd3a/RH+aNsbdS2/AzbH/zZ6AqpbPujjSr5YbkbtXNGd+ZXz0yHjPuRa5D10e4egL/GTJKBucBRz+/pk815GJJgOvDDv3YD/ljH1TE851iX9cUjCGoB2ta3SBWR1wvocEVZXIwU1nLTQYZAa9s/i4QeHGv66wMIw0Z1UYxP15XbPFfEc4XUnQX820dzezwP28Q5104bhyRrwezZ5BA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=sapience.com; s=arc6-rsa-220412;
        t=1693429747; c=relaxed/simple;
        bh=bx/1ye1ATCuKlYf8lNYXgl0XOYb5h0RDxuCDSH1XrAY=;
        h=DKIM-Signature:DKIM-Signature:Message-ID:Date:MIME-Version:
         User-Agent:Subject:Content-Language:To:Cc:References:From:
         In-Reply-To:Content-Type:Content-Transfer-Encoding; b=hZwQNQC0DN0iTB/FC0Jr/UnUoTcwUz8an4BmNJs2b3mdwBkEK1gpZsWsMBh2NiA3HMJvxeJ3hKxodAlqRFZpCCIg7JQYKBU4ZO1gDT+PGKbcJ2hpJZii7GQrsMPuZASfqQ6yoOvDWnqrEd4jnGsJJpsijjNHT7x0R5JDQpMqAgDF8WG7z4BBkNjH6k2ha2FXMyGnVcs6qzAKn4MwPzRInpdTJTpVUrMxf7zDAtXKcY04O52DRQA8M0Hepo7POWwuLdBpqOsL37EJi7i7mwS9PjqqMG4x0Z2zuV2YoVt6oGvztGnoQobA2ovld2Nt5mUdDM2QREdaphe5lvLthy9y/A==
ARC-Authentication-Results: i=1; arc-srv8.sapience.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sapience.com;
 i=@sapience.com; q=dns/txt; s=dk-rsa-220413; t=1693429747;
 h=message-id : date : mime-version : subject : to : cc : references :
 from : in-reply-to : content-type : content-transfer-encoding : from;
 bh=JAQWYBmETROLjbPGuqGIMm8OdFb4xMwJG4FqWN0oL6A=;
 b=cLbAIERhmhwAtcDdtpbtePCREplLgq9j6EIT267NRbrok72WqlW9WW8EC5L+mQ9h4mMa8
 R9hHPI9h/sYnhSDCYy873UwG3ZUadu39zAmIMpn0q9ABdUagio2PSNx9M7b6QqXo+SsJKJy
 fuyM+mBvskMdNYSyIm7qWODsdfTSvF3QBG3FkkRxr2v5lHpWpSwQKqL4DAEv0vBVkUQPnBA
 FgkvSIw20LbnQ8ldmSYYgdc20Im1+iLGrtCySZOF3wxbgDe2ArK9u+sJj00+i3O+YRxyCt7
 Pxtt4vurKiFVuNGDaWPV/U3cO1W/b4t1eXW/a2xeOqSXnZWFkLmYWqMzwABA==
Message-ID: <5d38cf11-114a-4997-a0fc-4627402468f8@sapience.com>
Date:   Wed, 30 Aug 2023 17:09:07 -0400
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
 <903830f8-9f9a-4071-9ced-761a55018c5a@sapience.com>
 <97cee217-e438-4fff-836a-186f59d6d256@sapience.com>
 <fa82d9dcbe83403abc644c20922b47f9@realtek.com>
From:   Genes Lists <lists@sapience.com>
In-Reply-To: <fa82d9dcbe83403abc644c20922b47f9@realtek.com>
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

...
> I think maybe it is a system power saving issue....
> In the past if the BIOS(config space) not set L1-substate, our driver will keep drive low CLKREQ# when HOST want to enter power saving state that make whole system not enter the power saving state.
> But this patch we release the CLKREQ# to HOST, make whole system can enter power saving state success when the HOST want to enter the power saving state, but I don't  know why your system can not wake out success from power saving stat on the platform
> 
> Ricky
>      

Hi

    Thanks for continuing to look into this. Can you share your thoughts 
on best way to proceed going forward - do you plan to revert or 
something else?

thanks

gene

