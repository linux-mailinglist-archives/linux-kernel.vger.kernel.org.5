Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5268F761CDC
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 17:05:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbjGYPFN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 11:05:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjGYPFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 11:05:05 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E8B82116
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 08:05:03 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 2CB04900EA3;
        Tue, 25 Jul 2023 15:05:02 +0000 (UTC)
Received: from pdx1-sub0-mail-a285.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 2B4AA9009CF;
        Tue, 25 Jul 2023 15:05:01 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1690297501; a=rsa-sha256;
        cv=none;
        b=rp5BrbKtX4VPafdI7b0e+zPk9qKy+q1oIhPSrqq+Cl+uHl+LrUIUUoX+qjdZtrArIAEYXH
        7neCftKu+xGdwCsuYaov/igao91OY/It/SpIMHjkc6VB9shxCzhm+ln5awUZ0Npz48Z96o
        CFkDZPRUmeFi1uYYpaui7buixDHY+DxPFi1iLSIdC4gZG6sfSA8QPhwZtkVe3J2uCk2MPP
        9cELeRdOwuo6fUloruLmO/6cj8JZUPQRw8hZEjze205KrJOU55nCbcFhJWHp/nKngVeEvQ
        dMQAQ+yniHFBhZpP5AJwzuxUp++gD6pj8O5/Je8Wj8TNUMkTlbFCbtwplOsz2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1690297501;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=DGFAtwXgxNGoQKG6EE9V8Gt6eTP4019qipNF37BKw4w=;
        b=MvReKXpeluu/0lJVZ7iTSnOD+t0J/OYqYPbaqcn6MgIkrehyB6gCTTSXJjAER2op1PCOQv
        c/HEDfKPGEJSPsl9MqGHYV0uVccSU7saZmpXLnMG2Lfz0TF2Q3ywCJMxlIHRI6JgaU6JAV
        V2nmO/iVXRR9sCUrMKZuVtQUk7ohMKT5KRPWxC0oAPLyxu9lqZTu8rQF0cDUvhCLsYbXwq
        8iVKG7iND0g3IN2MQ1VrqPrbjJZweBE28K+EMkDLJz1gObYvPTFLUz50Wz/nAEPq66ii+N
        uCA1SR1ZyxFFvpTqEsO6OAxDIZzNF8iVIFp27ypX1zcFSexHpIU+P62qehRXgw==
ARC-Authentication-Results: i=1;
        rspamd-bd8c8f549-8f6nd;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Print-Blushing: 6b6d26e9092db162_1690297501942_1941431111
X-MC-Loop-Signature: 1690297501942:258647740
X-MC-Ingress-Time: 1690297501942
Received: from pdx1-sub0-mail-a285.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.122.193.201 (trex/6.9.1);
        Tue, 25 Jul 2023 15:05:01 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a285.dreamhost.com (Postfix) with ESMTPSA id 4R9L183XdFz1H;
        Tue, 25 Jul 2023 08:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1690297500;
        bh=DGFAtwXgxNGoQKG6EE9V8Gt6eTP4019qipNF37BKw4w=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=MUQ7LJml5/ymkoxrgiqn/kGdPNZgro7ssdskKoktD4Iod24W7zVke/7CKhwFBBIgG
         glTlxQkT1wsfAD9CcJS80AmNwU/NyX4n2tWy7ZwqVBAmVtevoQgT6SdYECW6AUdi03
         0vRkP+RkHZ8XoplSswd/HM00FcwYY66vJWBZHgVP7ltf241HdeEgu8bJ+cNvpQyKtD
         58RGo+uJhiM9T0NbJdk2dNdJLKgjY12C0c6UHYbSKQ4XwzbozZOCi/Yde9/WbJ25Pz
         nmn24B8ndgYtsFqEKLCVAty/0ig876hxLlCKub8ZAtLyXa616I47/DEpCaQMivF67T
         gdfecY0uRgmLg==
Date:   Tue, 25 Jul 2023 07:27:49 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcuwait: Add might_sleep() annotations
Message-ID: <wznmrfzpx4zre2wgbjotzc3qwlj3asfjty47zkvnmfuc77vwja@o2tkl37ghgnm>
References: <20230724160337.20851-1-dave@stgolabs.net>
 <20230725120336.GG3765278@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230725120336.GG3765278@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20230517
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Jul 2023, Peter Zijlstra wrote:

>On Mon, Jul 24, 2023 at 09:03:36AM -0700, Davidlohr Bueso wrote:
>> ... as with regular waitqueues.
>
>No immediate objection, but please, tell us more. What made you get up
>this fine morning and write this patch?

So this was just something I had noticed missing while adding the
timeout support.

Thanks,
Davidlohr
