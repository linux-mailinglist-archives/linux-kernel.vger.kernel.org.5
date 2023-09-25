Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FE587AD4D7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 11:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbjIYJvv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 05:51:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjIYJvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 05:51:46 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95519C0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 02:51:39 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1c45c45efeeso5698335ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 02:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1695635499; x=1696240299; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6bDaROXosZFbxypZ/HbsqMYiNAkcfxciw+tGlY+rYeU=;
        b=Ww/3LeLdNSzMKLAkpPz0gj2FXArrYdSEqlsL3mQ9swSfmvzwNLykiKmrf/azIT/3fC
         qD1Yyaw8AXq421+VU15G5zhW9yo+fq+I8wf7c/I5N6c0xe52sdXzE2zypn414MeORGtN
         vYF/3CnaXOdkwSV31z0mEZ9ZlPAb3qq+RDONBiNdLJGBQVYdRRb7yQZfjg6glTh0ti1A
         cgM2+dsrOzAN/+SppAkPCWv+iIL+9yQ/WSC/6UI+MUXjt6AJddm5Ti9TvO7sLkmL316I
         D1/wBnk7xtaUqCosXKiHElN0qbZN88NUKEwKwgVUer6SVYbSQdUuIEnBhCuJElf+wyrs
         rcIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695635499; x=1696240299;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6bDaROXosZFbxypZ/HbsqMYiNAkcfxciw+tGlY+rYeU=;
        b=xJ0QxvoVTcOUMEvOaTcShFG5Cffba3BfaXOZVmAgNGyEzRO3eew1jUE4BjdsL3/0HP
         1yWNNxEDCF8ShbdeveKDokVA5mL1Fm+TiGbHNFkxz+HRB5issO5K6IuZjxfG+BnsZ+8o
         X/6K1QmwRnFB9Yh9HW7VFlGF8mMv/zUVyV02ViQyJto4UBCA5L+A3p7MpPEnP2XM+jnv
         hLWYoaLGyDoym0/YH225E/LU62Yqs9nkLjjjmpg1NOYQq6kKRcLK8vIzI3h7vaa+YZi0
         7crVqh8LXXOMWspJsgTwMeYvzVgldmDJ4NcAJRVuFS2Oe/jhBuAWla5YrrunimhE/55e
         sRpA==
X-Gm-Message-State: AOJu0YwekffM9y6HLQ1WrpnriQyVcwocm2fwH4Gg+n1rjq6cycjxREcu
        XWeuIg4DHpzhzSOKYOhPrvlaHQ==
X-Google-Smtp-Source: AGHT+IEL4SKPtQ8PAes8V97jql6XtLNcHPyUdJHnX/z3vjsVjPb+hoPuhUEeKkfGy/a39JaX+7fVTw==
X-Received: by 2002:a17:902:ecce:b0:1c4:1e65:1e5e with SMTP id a14-20020a170902ecce00b001c41e651e5emr8550430plh.0.1695635498999;
        Mon, 25 Sep 2023 02:51:38 -0700 (PDT)
Received: from smtpclient.apple (mobile-166-171-251-202.mycingular.net. [166.171.251.202])
        by smtp.gmail.com with ESMTPSA id l19-20020a170902d35300b001bc6e6069a6sm8424373plk.122.2023.09.25.02.51.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Sep 2023 02:51:38 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Jens Axboe <axboe@kernel.dk>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] ovl: disable IOCB_DIO_CALLER_COMP
Date:   Mon, 25 Sep 2023 11:51:25 +0200
Message-Id: <10D8C1CC-07FB-47B1-8326-5EDEA53E166B@kernel.dk>
References: <20230925-desorientiert-fahrverbot-d95744ccc37f@brauner>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-unionfs@vger.kernel.org, Zorro Lang <zlang@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>
In-Reply-To: <20230925-desorientiert-fahrverbot-d95744ccc37f@brauner>
To:     Christian Brauner <brauner@kernel.org>
X-Mailer: iPhone Mail (21A340)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 25, 2023, at 11:39=E2=80=AFAM, Christian Brauner <brauner@kernel.org>=
 wrote:
>=20
> =EF=BB=BF
>>=20
>> No problem - and thanks, maybe Christian can pick this one up? I
>=20
> Snatched it I've got a pile I need to send to Linus this week anyway.
> (Thanks for the Cc, Amir!)

Perfect, thanks!

