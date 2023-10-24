Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD2867D4566
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 04:17:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231459AbjJXCRX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 22:17:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjJXCRV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 22:17:21 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DE28C4;
        Mon, 23 Oct 2023 19:17:19 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id d2e1a72fcca58-6bcbfecf314so814226b3a.1;
        Mon, 23 Oct 2023 19:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698113839; x=1698718639; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zyEFDhAWm65pg1j3rI0ZzRtuZnY7gYN9zi0XKDJuvm8=;
        b=JtHzB6oC4uEclOz04uT3WtT02ejjVv95OXkGMMwL+ZZ1vHKnZhcE4TYrjf37UGDgdY
         1ifU9jEU7XUMDGBkqRUbFLptIizPivRtN5IXH62y3+t6ENsK9lW7weX9b3qnRaUvv2Yz
         T3AgzI7D2YAKzeXfthsn3Euy9TLKjiVk+ou8Aeu/gl2dEAylX1bZpinHRLOZq054jkMx
         AFX76l8Fjnz+b6HLu/U3aOvpLX3eY8AIZRiqjo5PpK9JzpmBUvPCtlSQr6Ob4Q87MbmB
         N2y1nmuM8VguZY0jUrB615rrJKRyxYAETkIRkJ/3HFOujruQfB8p6Nb91lObxE7QM5EV
         RqSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698113839; x=1698718639;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zyEFDhAWm65pg1j3rI0ZzRtuZnY7gYN9zi0XKDJuvm8=;
        b=rof0iK0SJUva5oitSkh2zFLqGFraprfB7rFj8UUGts2Bhy7/zsMXthQ3hlgh4Xue1n
         fvtvAxz0vRR13kvY+GC99iRiOWV+ADvV3bdnfH2QxZjpkQ1Mx6YoMSUdnDpbj9VzEnfU
         hvnm04c2bVHlZ6t5X6r/3cNOxk+ZulE1x+CbobYAVuT+rLfLWHs84LF3/VYOIaEk2OLF
         amfBnhs1VDD31uvqQrdbBz3jhDeWwjX/diYMsZIC4i0U4L+4JEINt22V/XDqAVmZbKDk
         7opX9KjDw0hS35KTSnV1uXx62HCtcTrmdGUujEMPoeEaxoNt9RVmG25xLKsiKdScdsXW
         XslA==
X-Gm-Message-State: AOJu0YwhG6iTnKXoIwcumKcEt6Y5ixN+SYv7oBhLATTuGFA0BzG4/Kph
        ewbm7Rdco3doWrODtAiB9ws=
X-Google-Smtp-Source: AGHT+IE9fvMwgsqbR5lA/PxMEX4lZmpmQMzM0WUD/UVQEP0lwtXuL3w2pLyDP/a5H/OpbO7q2gcxEA==
X-Received: by 2002:a05:6a20:8f03:b0:13f:65ca:52a2 with SMTP id b3-20020a056a208f0300b0013f65ca52a2mr15761981pzk.5.1698113838741;
        Mon, 23 Oct 2023 19:17:18 -0700 (PDT)
Received: from [127.0.0.1] (059149129201.ctinets.com. [59.149.129.201])
        by smtp.gmail.com with ESMTPSA id 5-20020a170902e9c500b001c72c07c9d9sm6591188plk.308.2023.10.23.19.17.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Oct 2023 19:17:18 -0700 (PDT)
Message-ID: <120e6c2c-6122-41db-8c46-7753e9659c70@gmail.com>
Date:   Tue, 24 Oct 2023 10:17:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: tls: Fix possible NULL-pointer dereference in
 tls_decrypt_device() and tls_decrypt_sw()
To:     Sabrina Dubroca <sd@queasysnail.net>
Cc:     borisp@nvidia.com, john.fastabend@gmail.com, kuba@kernel.org,
        davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231023080611.19244-1-hbh25y@gmail.com> <ZTZ9H4aDB45RzrFD@hog>
Content-Language: en-US
From:   Hangyu Hua <hbh25y@gmail.com>
In-Reply-To: <ZTZ9H4aDB45RzrFD@hog>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/10/2023 22:03, Sabrina Dubroca wrote:
> 2023-10-23, 16:06:11 +0800, Hangyu Hua wrote:
>> tls_rx_one_record can be called in tls_sw_splice_read and tls_sw_read_sock
>> with msg being NULL. This may lead to null pointer dereferences in
>> tls_decrypt_device and tls_decrypt_sw.
>>
>> Fix this by adding a check.
> 
> Have you actually hit this NULL dereference? I don't see how it can
> happen.
> 
> darg->zc is 0 in both cases, so tls_decrypt_device doesn't call
> skb_copy_datagram_msg.
> 
> tls_decrypt_sw will call tls_decrypt_sg with out_iov = &msg->msg_iter
> (a bogus pointer but no NULL deref yet), and darg->zc is still
> 0. tls_decrypt_sg skips the use of out_iov/out_sg and allocates
> clear_skb, and the next place where it would use out_iov is skipped
> because we have clear_skb.

My bad. I only checked &msg->msg_iter's address in tls_decrypt_sw and 
found it was wrong. Do I need to make a new patch to fix the harmless 
bogus pointer?

> 
> Relevant parts of tls_decrypt_sg:
> 
> static int tls_decrypt_sg(struct sock *sk, struct iov_iter *out_iov,
> 			  struct scatterlist *out_sg,
> 			  struct tls_decrypt_arg *darg)
> {
> [...]
> 	if (darg->zc && (out_iov || out_sg)) {
> 		clear_skb = NULL;
> [...]
> 	} else {
> 		darg->zc = false;
> 
> 		clear_skb = tls_alloc_clrtxt_skb(sk, skb, rxm->full_len);
> [...]
> 	}
> 
> [...]
> 	if (err < 0)
> 		goto exit_free;
> 
> 	if (clear_skb) {
> 		sg_init_table(sgout, n_sgout);
> 		sg_set_buf(&sgout[0], dctx->aad, prot->aad_size);
> 
> 		err = skb_to_sgvec(clear_skb, &sgout[1], prot->prepend_size,
> 				   data_len + prot->tail_size);
> 		if (err < 0)
> 			goto exit_free;
> 	} else if (out_iov) {
> [...]
> 	} else if (out_sg) {
> 		memcpy(sgout, out_sg, n_sgout * sizeof(*sgout));
> 	}
> [...]
> }
> 
