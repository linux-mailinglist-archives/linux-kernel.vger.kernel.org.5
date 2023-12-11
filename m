Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A528B80C37F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 09:44:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233934AbjLKIog (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 03:44:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjLKIoe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 03:44:34 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EAAEA0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 00:44:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702284279;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5LWTtRj4KzcXU71hLoOO86zVSMhjA4YYS/eymtJ/IMY=;
        b=DRvzhjNnn0g4bqrQsckei0AEBr2UA1Bai4MklJLlWfZsdeO/G6DCVdoFjer/lBFW5vBPYk
        PzYxMGufmCjXBhzBjt+r6dOsUPusJG5aX+MJD11DsEevsws1fj4vCQGbLBL0Y30domWFo7
        jFHWFGY/pZ+Y7l/WPFkJwDsEmY0Plwc=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-219-2LdrRY9_PReTBEJQG3ZCFw-1; Mon, 11 Dec 2023 03:44:37 -0500
X-MC-Unique: 2LdrRY9_PReTBEJQG3ZCFw-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a1d3a7dbb81so75749766b.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 00:44:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702284276; x=1702889076;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5LWTtRj4KzcXU71hLoOO86zVSMhjA4YYS/eymtJ/IMY=;
        b=AR8Mv0zatmnmM+nGTW0UeE1BtwHtfUk39gp2vttsLfoEMOzXoUFzB7xXXW1H7elo+J
         Fb6jLhF3HAIFMZ0b6wRJQqV8EH+yhFfXwXBXqsNftrflSourN9lohgILZNTsjKMyRI5Q
         +fTRxSaSgW35kCCVrR8ChjJO8oWWntZSe1xIwdCG3a+rRf+ZZyICWBRJGia0HCXN7fzt
         bJ8MMRFTy3ifb/C8yVKV+Us+IFmq7QbnYhQpMaJDjEIZi0dnv4m37wnA7oX6IsjYyeOw
         /QFnM7ZL78WZotLm0sqjSP6Y97AjQERlX80cNyHkPOx2+dYdVIA1Ip70IjTkm0Ynv5Wj
         whnQ==
X-Gm-Message-State: AOJu0YyE0ZTL0IJI+ClMwL8RkZdYy9582JxYv2U0xihSoKZm6oqwymJP
        eWWVqh8Hy49F4+jflk5cnlBl4e601A7vLT0e9hxgO35s7HSobyAjevMN/zmj9HlKT6kqmJNN7nP
        q9qw8Ml3MhKfaiHUq27yRroyEBVKTANRA
X-Received: by 2002:a17:907:c207:b0:a1d:7daa:4efd with SMTP id ti7-20020a170907c20700b00a1d7daa4efdmr4169688ejc.4.1702284276122;
        Mon, 11 Dec 2023 00:44:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHNBRffJXrCxYOfF2BE+lbKihjhGNMeES2n78bLLuyerFEqjYofvkFyNmZteUY/bpceg17JIw==
X-Received: by 2002:a17:907:c207:b0:a1d:7daa:4efd with SMTP id ti7-20020a170907c20700b00a1d7daa4efdmr4169680ejc.4.1702284275807;
        Mon, 11 Dec 2023 00:44:35 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-253-165.dyn.eolo.it. [146.241.253.165])
        by smtp.gmail.com with ESMTPSA id cb6-20020a170906a44600b00a1e2aa3d093sm4387337ejb.202.2023.12.11.00.44.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 00:44:35 -0800 (PST)
Message-ID: <83ef2da88811e616b029c50a66ffdfab52493e2d.camel@redhat.com>
Subject: Re: [syzbot] [net?] [nfc?] KASAN: slab-use-after-free Read in
 nfc_alloc_send_skb
From:   Paolo Abeni <pabeni@redhat.com>
To:     Siddh Raman Pant <code@siddh.me>,
        syzbot+bbe84a4010eeea00982d@syzkaller.appspotmail.com
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Date:   Mon, 11 Dec 2023 09:44:34 +0100
In-Reply-To: <aa9e49a1-7450-4df4-8848-8b2b5a868c28@siddh.me>
References: <0000000000003e8971060c110bcc@google.com>
         <aa9e49a1-7450-4df4-8848-8b2b5a868c28@siddh.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2023-12-09 at 16:09 +0530, Siddh Raman Pant wrote:
> Final test
>=20
> #syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.=
git master

Please, don't cc the netdev ML for tentative syzbot-related fixes: it
confuses patchwork and increases the traffic here for no good reasons.

Thanks!

Paolo

