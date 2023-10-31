Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 727CA7DCFB0
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 15:54:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344509AbjJaOum (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 10:50:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344537AbjJaOuj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 10:50:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78B78DB
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 07:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698763790;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wC70NjzSUr4LvW8CC2+ZDGZgQqRztYwHl/WFtd4ZzKQ=;
        b=W6xGdnp+NZrX3XnWnClDT7ZKWRYiqIFD7LgZH4OPjQbqwMtSd5aHV8iypJDmQxJAurdy+o
        KseLHRM4OZgEEx20EsUWjsk4bzuFx+Br5ORl2NjG+JsX+cAamueEyMlzf0BTWwkUnrE9Lj
        xw8byqRJtb/bV6XBcLw7zrQormqznRo=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-670-GjygX67INJOScWAbzJ1hvg-1; Tue, 31 Oct 2023 10:49:49 -0400
X-MC-Unique: GjygX67INJOScWAbzJ1hvg-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-41e1899175eso13690931cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 07:49:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698763788; x=1699368588;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wC70NjzSUr4LvW8CC2+ZDGZgQqRztYwHl/WFtd4ZzKQ=;
        b=PnqqPiu+HX962i2G4ebQtNSgM4o7bRvgGRFNyS8e2UyW845mPSK4Cf7/DHerAuOyQq
         OWj/9gN3yDUvTDKOghlyto9RiGmaQ8uZ9F3FHyITajlvFNklPuSlUK2CkNfGomUOyoFB
         pN3mYHhKwpjpbslglUAtCaORVWIVfP8rJpyBKIhO6kPJBribBy/8caECjzVzPdFdkqt6
         zhfYYqKe4ScqdeP0rSgh+LNvue6uRSZmFCzDpyekSsOuYRSvwJRNxKvb8XsLxW3WwLux
         8FtdY00qnnDFMPmo6wnyCymOwACabPMzSXl/dONouCQn3NrMkDpoKY5lOKV8ZlofwgsN
         cjIQ==
X-Gm-Message-State: AOJu0YwPr/6N9jNcSPddprgom24ET1Iy2nhSwTQiqbS5Zi4RGr4l9Mtd
        TdmiXv40ElWBL24+TwQM/ZbIKiqqWkJf1epso1bz4lwXBZhGJvTNnxXeX9ud+RZzEYyPCNNRAwV
        Lgk7yqIdOr2xCjecAgaLHdT1I
X-Received: by 2002:ac8:7f55:0:b0:412:3189:9fd6 with SMTP id g21-20020ac87f55000000b0041231899fd6mr17244329qtk.5.1698763788682;
        Tue, 31 Oct 2023 07:49:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IERjLWjRB1kJMdKCpg3B7l9DrSVVOpzcHbJPKkiapAIsGI8t+/ULpCGqcZBZO9DVV9mcj7SuA==
X-Received: by 2002:ac8:7f55:0:b0:412:3189:9fd6 with SMTP id g21-20020ac87f55000000b0041231899fd6mr17244308qtk.5.1698763788353;
        Tue, 31 Oct 2023 07:49:48 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-227-179.dyn.eolo.it. [146.241.227.179])
        by smtp.gmail.com with ESMTPSA id jt21-20020a05622aa01500b0041b3deef647sm558815qtb.8.2023.10.31.07.49.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 07:49:48 -0700 (PDT)
Message-ID: <c1f3236d0a2a2f540f65815633e709accdbc197a.camel@redhat.com>
Subject: Re: [PATCH v2] selftests/net: synchronize udpgso_bench rx and tx
From:   Paolo Abeni <pabeni@redhat.com>
To:     Lucas Karpinski <lkarpins@redhat.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        shuah@kernel.org, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 31 Oct 2023 15:49:45 +0100
In-Reply-To: <vzz3qfbfq52qja24y25lopif27sdwyvz3jmmcbx5wm6jc5l53b@fy7ym6xk4zsb>
References: <6ceki76bcv7qz6de5rxc26ot6aezdmeoz2g4ubtve7qwozmyyw@zibbg64wsdjp>
         <e8a55d0518da5c1f9aba739359150cad58c03b2b.camel@redhat.com>
         <vzz3qfbfq52qja24y25lopif27sdwyvz3jmmcbx5wm6jc5l53b@fy7ym6xk4zsb>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-10-31 at 09:26 -0400, Lucas Karpinski wrote:
> > Since you wrote the same function verbatim in 3 different files, I
> > think it would be better place it in separate, new, net_helper.sh
> > file
> > and include such file from the various callers. Possibly
> > additionally
> > rename the function as wait_local_udp_port_listen.
> >=20
> Thanks, I'll move it over. I think it would be best though to leave
> udp out of the name and to just pass the protocol as an argument.

Indeed. I suggested the other option just to keep it the simpler, but
if you have time and will, please go ahead!

Cheers,

Paolo

