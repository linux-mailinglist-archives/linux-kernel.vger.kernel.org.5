Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF75876BB2E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 19:27:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232053AbjHAR1J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 13:27:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230297AbjHAR1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 13:27:07 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 707F8CC
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 10:27:04 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-99bcf2de59cso923051066b.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Aug 2023 10:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1690910823; x=1691515623;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zEQoCBAZE+MrFQ0nMFtOlsgCpzDjMhKc4sVhqgkx9HM=;
        b=SAGRQppniqtpk3rcPElEYgz1NyJdUcNTggSyjoc0wjKjaftLOjT3ugkqywXIIETU74
         6BtJ7wrTbFM18bf+Ih3ZqtGJXzUTh+NCWcKLkqb7riKqO9wJFFp4rtHIFscwrh21nVPk
         VI//uuh4Roe2Q7ZNsz3pDzaVhsnZsOaumgPXhIoKTWXWwzxN1VMm1JLRmxGb8SC1rdHY
         lTNVhRQMXVdGbZJJnuliITa6FvOWoY/DjLZqI2CWp8OM0ckByB16AVQ87sjeGlV2h9de
         ph+v5rind7isXpqv63AY/5C9xrxFm3drQ6VIZ2ZA1W2+FOb/MJwrEca1YX/EnMBGlCS7
         fVvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690910823; x=1691515623;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zEQoCBAZE+MrFQ0nMFtOlsgCpzDjMhKc4sVhqgkx9HM=;
        b=liSK+q5Q6qcWiRzujwHsKMWQTJTLTCZBZ9/XkST9IXsVUAG846SsHJCLFTCGi9SMXP
         nCXTxY5sGdD7dkFsoCRO3+WI/JexYxMpCqraQqFItgAVv4y10cNmGLFhHVcp9rWHLX03
         195wPlVniNoGCXfCc1j2JgZ8mhEpUjvmNI2xk2mg3E2n1gSUV6C7jGDAqyn1c9l2IBUa
         Jhoua+E6Bp8cAH2vytfs6UAwPmI/u9pJl+N6W8jaFFtN9FxXmkr8WKNPxz8PyxX18wdA
         82HZxBsx7IPq3DJzISrvgFA2ZWGf5JBkkZmoQVcx+FemnLhagHlgCylw8twUsndElYYh
         IZwQ==
X-Gm-Message-State: ABy/qLZAl3PDV95riyNUqlHbDHZKMsEFbuXqIH0HGIB6mo8JfZKqqulk
        +7RsP9npLU41ACWSIRYEMaJEIw==
X-Google-Smtp-Source: APBJJlEYA4oxxOGVRYBjWgY0YEmsYh+uGbqMnSpHCYWTwyPci+Bj1hZ6C2f4wy1loM47PlodnHEOHA==
X-Received: by 2002:a17:906:53cd:b0:99b:c2d4:ddd8 with SMTP id p13-20020a17090653cd00b0099bc2d4ddd8mr3250035ejo.31.1690910822788;
        Tue, 01 Aug 2023 10:27:02 -0700 (PDT)
Received: from localhost ([212.23.236.67])
        by smtp.gmail.com with ESMTPSA id i10-20020a170906250a00b009931baa0d44sm8029171ejb.140.2023.08.01.10.27.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 10:27:02 -0700 (PDT)
Date:   Tue, 1 Aug 2023 19:27:01 +0200
From:   Jiri Pirko <jiri@resnulli.us>
To:     Anvesh Jain P <quic_ajainp@quicinc.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Simon Horman <simon.horman@corigine.com>,
        Kuniyuki Iwashima <kuniyu@amazon.com>,
        Hangbin Liu <liuhangbin@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Andy Ren <andy.ren@getcruise.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Venkata Rao Kakani <quic_vkakani@quicinc.com>,
        Vagdhan Kumar <quic_vagdhank@quicinc.com>
Subject: Re: [PATCH] net: export dev_change_name function
Message-ID: <ZMlAZdWX3EToTUVT@nanopsycho>
References: <20230801112101.15564-1-quic_ajainp@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230801112101.15564-1-quic_ajainp@quicinc.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tue, Aug 01, 2023 at 01:21:01PM CEST, quic_ajainp@quicinc.com wrote:
>export dev_change_name function to be used by other modules.
>
>Signed-off-by: Vagdhan Kumar <quic_vagdhank@quicinc.com>
>Signed-off-by: Anvesh Jain P <quic_ajainp@quicinc.com>
>---
> net/core/dev.c | 1 +
> 1 file changed, 1 insertion(+)
>
>diff --git a/net/core/dev.c b/net/core/dev.c
>index 69a3e544676c..1dad68e2950c 100644
>--- a/net/core/dev.c
>+++ b/net/core/dev.c
>@@ -1254,6 +1254,7 @@ int dev_change_name(struct net_device *dev, const char *newname)
> 
> 	return err;
> }
>+EXPORT_SYMBOL(dev_change_name);
> 
> /**
>  *	dev_set_alias - change ifalias of a device
>
>base-commit: 0a8db05b571ad5b8d5c8774a004c0424260a90bd

nack.
1) there is no in-tree user
2) changing name from anywhere else than userspace does not make any
   sense. I'll eat my shoes if there is a sane reason for it.

Please don't send patches like this.


>-- 
>2.17.1
>
