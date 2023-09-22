Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D31B67AB615
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 18:35:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231815AbjIVQfT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 12:35:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230403AbjIVQfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 12:35:16 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 474AC194
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 09:35:10 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-9aa0495f9cfso874647866b.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 09:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1695400508; x=1696005308; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gOhjx56+C1/SUOCT4pJr+RaAn7PBsJsy8c2/c8L0wsg=;
        b=VXldlrG11szZBfan3YaFaOg1qRTFUXItPvz+d594Ed/RZo0X8fDhhFTcT+Tfee5VSP
         yLE9fyNVXNnPLkw0gSESTe8Z8WM+wGotLZjHCgzE0IfCnJJtL1u/7KVdSA3g4FbBQDNs
         0yJxayfVAnOtmdEA4zWcMbTKTM0gvJiAOw2es=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695400508; x=1696005308;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gOhjx56+C1/SUOCT4pJr+RaAn7PBsJsy8c2/c8L0wsg=;
        b=PdS9LDURoBHlSiFkoBkFakAlCo0Fbm+x+P6l8LsAm0Oo2Hdwo8iPx9HkqpNwdmAdpc
         QME+Eg3GOw6RN+ws9ezUGASiDM9nNXAyzqUvWq9Thy1hJXBlA/EKgs9am6T4Mv226d/C
         sGSoXeQ7RgGtxGk4SJk4oEqfoASZmcduJGicTeM9wS2bmVPh6ckASzrynwARcPeRImST
         FZ1rE5PXFrIXFLZ+Htx1WYaoCR2UGtrrZrir3xBKatuTj8pv/H6ZP8b5AJNVP0hT41SZ
         0s1AZeTShsfi/WBT9xW/za7UPyQRasUogTJQd7U3WFuq6pN/sLyXCTL8H46JI4QPtkIb
         lFtw==
X-Gm-Message-State: AOJu0YwspwObodcignxCs3gEJ+0YoBWKTfZs2ghyy8KX1PyWzC0A0k/l
        mTMtytjPohjy7V4+XuMmUqxVQq7rbrw6LNAUjQuCDgT9
X-Google-Smtp-Source: AGHT+IGsopiyJB7/2zTHORml3CRqxK7qdsGg7JTq7ttoek7ATkGbuYyWz0EIbrsDuRTEYEgjP9t8ww==
X-Received: by 2002:a17:906:5357:b0:993:eee4:e704 with SMTP id j23-20020a170906535700b00993eee4e704mr260053ejo.38.1695400508684;
        Fri, 22 Sep 2023 09:35:08 -0700 (PDT)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id jx10-20020a170906ca4a00b009ad87d1be17sm2892178ejb.22.2023.09.22.09.35.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Sep 2023 09:35:07 -0700 (PDT)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-51e28cac164so8589107a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 09:35:07 -0700 (PDT)
X-Received: by 2002:a05:6402:27ca:b0:52c:f73:3567 with SMTP id
 c10-20020a05640227ca00b0052c0f733567mr4854122ede.13.1695400507255; Fri, 22
 Sep 2023 09:35:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230922120227.1173720-1-dhowells@redhat.com> <20230922120227.1173720-9-dhowells@redhat.com>
In-Reply-To: <20230922120227.1173720-9-dhowells@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 22 Sep 2023 09:34:49 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgW5z-OBA8kbOOoM7dAriOsb1j7n6GaUNjGeg9fPY=JRw@mail.gmail.com>
Message-ID: <CAHk-=wgW5z-OBA8kbOOoM7dAriOsb1j7n6GaUNjGeg9fPY=JRw@mail.gmail.com>
Subject: Re: [PATCH v6 08/13] iov_iter: Don't deal with iter->copy_mc in memcpy_from_iter_mc()
To:     David Howells <dhowells@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>,
        Christian Brauner <christian@brauner.io>,
        David Laight <David.Laight@aculab.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jeff Layton <jlayton@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-mm@kvack.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Sept 2023 at 05:02, David Howells <dhowells@redhat.com> wrote:
>
> iter->copy_mc is only used with a bvec iterator and only by
> dump_emit_page() in fs/coredump.c so rather than handle this in
> memcpy_from_iter_mc() where it is checked repeatedly by _copy_from_iter()
> and copy_page_from_iter_atomic(),

This looks fine now, but is missing your sign-off...

             Linus
