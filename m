Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A3187D079B
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 07:32:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345479AbjJTFcw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 01:32:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232838AbjJTFcu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 01:32:50 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E3DD119
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 22:32:48 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id 6a1803df08f44-66cee0d62fbso3190036d6.3
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 22:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1697779967; x=1698384767; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gIgRMVZRHWuc6XXVkWqSeW2ex2b1ilZhxXYHLgoWugw=;
        b=DOiEkaj/uhP6PcnrvTJGVIXCo55WXYXvwiU6o//9FErDjmw/BxHAnBrux42mxyLm5n
         8uVB90n8O5iDM/YuauzEK3I/dL0LmeL/wSepWeshU3Tp8Ec4i89wCALMXjakNZOHFMFw
         YZAhtF7Ai0XgIdkUIe3DTLH9WzRtwca8VHdui0UwGolpRucGmeVnhjGduVzd5C4pTYrN
         PR0htwUij43npmf2puO5NDd380CrOVgIF20Uv/A5hLu6dKDNtzQec8Ah5z8PEWVIm5j9
         62DD01Hvm7Qqy0mGhayJyPy/OOGM8njkOrwJ0tbprfAxiqBYFQW1/lsmjZXFaC4+1D42
         v7FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697779967; x=1698384767;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gIgRMVZRHWuc6XXVkWqSeW2ex2b1ilZhxXYHLgoWugw=;
        b=qLu6rQpAPiMk1hzw/V9rXfNxYQP9tULFJ1LKtzbhesne2PE3f+vpgkKaPheAQgnIOA
         p7wp7R8DWQOOmvLV0XgsLj9W40Cvmc8CGuu4oI9dbtqbpr4a4qcCZKgd1haJ+n8roA0t
         K2tFZMnBTsk21LtcscQL22YvBeR6np44vtcY1SDVf6YRYsezRlOOKvGVsXp8cIbFYWTy
         kPtobRliVoZ+mcWxH9WIyE6xmuULqSg6f0vjPK0KcRms5tA9Ubu38pRZMRq0mlRp/eIg
         I39lBLkLmggpPc+x9pWOZykHnCFEOp+Gbc4lJUz4qOtPOQdm4cpaYCJRz84+xAAXugcr
         sxSg==
X-Gm-Message-State: AOJu0Yw+WmUfSSh52FDztkAJpj4PtOCeZdYBjpxQpgub+EoWDRm+78Gu
        5CqOczdzto65lDACOcIYw+cSZg==
X-Google-Smtp-Source: AGHT+IGZE4svkFMX0jE6J9baXiN8oiOP9Hxbn+8YqaUYtgXBkU7gYhDSTBIVnKXkCxtDung2ZRsS4g==
X-Received: by 2002:a05:6214:2a8e:b0:66d:51cd:d7e9 with SMTP id jr14-20020a0562142a8e00b0066d51cdd7e9mr874539qvb.43.1697779967702;
        Thu, 19 Oct 2023 22:32:47 -0700 (PDT)
Received: from debian.debian ([140.141.197.139])
        by smtp.gmail.com with ESMTPSA id vq6-20020a05620a558600b0076e672f535asm359050qkn.57.2023.10.19.22.32.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 22:32:47 -0700 (PDT)
Date:   Thu, 19 Oct 2023 22:32:46 -0700
From:   Yan Zhai <yan@cloudflare.com>
To:     netdev@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        David Ahern <dsahern@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Aya Levin <ayal@nvidia.com>,
        Tariq Toukan <tariqt@nvidia.com>, linux-kernel@vger.kernel.org,
        kernel-team@cloudflare.com, Florian Westphal <fw@strlen.de>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Alexander H Duyck <alexander.duyck@gmail.com>
Subject: [PATCH v3 net-next 0/3] ipv6: avoid atomic fragment on GSO output
Message-ID: <cover.1697779681.git.yan@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the ipv6 stack output a GSO packet, if its gso_size is larger than
dst MTU, then all segments would be fragmented. However, it is possible
for a GSO packet to have a trailing segment with smaller actual size
than both gso_size as well as the MTU, which leads to an "atomic
fragment". Atomic fragments are considered harmful in RFC-8021. An
Existing report from APNIC also shows that atomic fragments are more
likely to be dropped even it is equivalent to a no-op [1].

The series contains following changes on IPv6 output:
* drop dst_allfrag check, which is always false now
* refactor __ip6_finish_output code to separate GSO and non-GSO packet processing,
  mirroring IPv4 side logic
* avoid generating atomic fragment on GSO packets

Link: https://www.potaroo.net/presentations/2022-03-01-ipv6-frag.pdf [1]

change log:
V2 -> V3: split the changes to separate commits as Willem de Bruijn suggested
V1 is incorrect and omitted

V2: https://lore.kernel.org/netdev/ZS1%2Fqtr0dZJ35VII@debian.debian/

Yan Zhai (3):
  ipv6: remove dst_allfrag test on ipv6 output
  ipv6: refactor ip6_finish_output for GSO handling
  ipv6: avoid atomic fragment on GSO packets

 net/ipv6/ip6_output.c | 31 ++++++++++++++++++++++---------
 1 file changed, 22 insertions(+), 9 deletions(-)

-- 
2.30.2


