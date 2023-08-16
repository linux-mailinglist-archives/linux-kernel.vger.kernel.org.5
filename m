Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9016077E910
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 20:52:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345656AbjHPSvY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 14:51:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345654AbjHPSvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 14:51:17 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D427426B7
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 11:51:16 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-3178dd771ceso6062862f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 11:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1692211875; x=1692816675;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZaKaeU51JPSPyvo4LO/gtZBA5F2n47wdQ6cksSuHE10=;
        b=fActoLYapvYatp3BhqIIHFa7afpVUfbRmNLj+3diEzvHES+AYjublIkhtmIOX9kg+Y
         gF0sFYtTPoeu6+U9v7D6JyEtUHF/XcjF8Qu4L8o8ftiwiy8vdZuS3YJKoYljq6C7Zp8U
         XapjcDw7BAY+29BhsfAA7mfdmQuqWLm7Tv9u4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692211875; x=1692816675;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZaKaeU51JPSPyvo4LO/gtZBA5F2n47wdQ6cksSuHE10=;
        b=TZKtHeKwjvT37okP6/j6IdWv6ju2YR9dvugmHvgHbKEdRvStW6GZVCgTGIP4Mf62P2
         PidHiIuW7nEWu8H+VZAfRPVVcIzLXQ63OaI0fsTLL8mEPYN2jU+pRCK21MTO4heAucZ4
         1HOGi7Pzc4Fxb14egq7VEM+RN1MOyX0s0IYgfsJDYJK0IaIW40H5EF8D29zwMSKxQXOj
         rB/vIHQcrkCIcr+AB0NWi4Q/xDyo7/NS3a4+8SuDYI31XjQflRYcAADRZGa1xBJUdGPU
         wTcYON4WMauU5QkQ1EUxs/V09DMqbiTNqKEMEszUUGHqn47OUe8oqu8NDaepdRvjBgK2
         1KQg==
X-Gm-Message-State: AOJu0YwEljN3+wqgixxe4hAfnoCEci5zE7r02O/XlNHCl3ti9PJ8RyM0
        OiPjhFW/gQ9tD1P4TDx/tcyKihw07rNZZhVeWZvajfTJ
X-Google-Smtp-Source: AGHT+IGQBcOww0EHncWKWsVZYdAPaRlqBepye8QH5aARMX67LlaTvsHaVKFRDDe1RUPa7ylikJjblQ==
X-Received: by 2002:a5d:4084:0:b0:319:67ac:4191 with SMTP id o4-20020a5d4084000000b0031967ac4191mr1856822wrp.37.1692211875044;
        Wed, 16 Aug 2023 11:51:15 -0700 (PDT)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com. [209.85.208.49])
        by smtp.gmail.com with ESMTPSA id f8-20020a17090624c800b009894b476310sm8773484ejb.163.2023.08.16.11.51.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Aug 2023 11:51:14 -0700 (PDT)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-51d95aed33aso9268336a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 11:51:13 -0700 (PDT)
X-Received: by 2002:a05:6402:1854:b0:525:69ec:e1c8 with SMTP id
 v20-20020a056402185400b0052569ece1c8mr1797634edy.40.1692211873612; Wed, 16
 Aug 2023 11:51:13 -0700 (PDT)
MIME-Version: 1.0
References: <03730b50cebb4a349ad8667373bb8127@AcuMS.aculab.com>
 <20230816120741.534415-1-dhowells@redhat.com> <20230816120741.534415-3-dhowells@redhat.com>
 <608853.1692190847@warthog.procyon.org.uk> <3dabec5643b24534a1c1c51894798047@AcuMS.aculab.com>
In-Reply-To: <3dabec5643b24534a1c1c51894798047@AcuMS.aculab.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 16 Aug 2023 18:50:56 +0000
X-Gmail-Original-Message-ID: <CAHk-=wjFrVp6srTBsMKV8LBjCEO0bRDYXm-KYrq7oRk0TGr6HA@mail.gmail.com>
Message-ID: <CAHk-=wjFrVp6srTBsMKV8LBjCEO0bRDYXm-KYrq7oRk0TGr6HA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] iov_iter: Don't deal with iter->copy_mc in memcpy_from_iter_mc()
To:     David Laight <David.Laight@aculab.com>
Cc:     David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@list.de>,
        Christian Brauner <christian@brauner.io>,
        Matthew Wilcox <willy@infradead.org>,
        Jeff Layton <jlayton@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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

On Wed, 16 Aug 2023 at 14:19, David Laight <David.Laight@aculab.com> wrote:
>
> What about ITER_BVEC_MC ??

That probably would be the best option. Just make it a proper
ITER_xyz, instead of an odd sub-case for one ITER (but set up in such
a way that it looks like it might happen for other ITER_xyz cases).

                Linus
