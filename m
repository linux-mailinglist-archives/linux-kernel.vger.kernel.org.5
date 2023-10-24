Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACFBE7D47FE
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 09:09:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232562AbjJXHI6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 03:08:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232714AbjJXHIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 03:08:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42162110
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 00:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698131288;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e2ft1iIUeqg/aot+9+OZB9Lfvws+RDiPr3cR/Bz0A1g=;
        b=UzkfCgbyIVDbsENfkEmuQ+Rz/3ZaJDwTv6pmduVxxFx6cdPaK+TX05kMxaVTPaMuLLNGDG
        4N1jvS4/pPUnfFMNgFsgeC46uBxA5ocTeu3NQ2FR1YOmKEi6wlSHCMJwb/SBL0y0kpoLhW
        qd/xux/vVrxd1EGvUcr7EH+3VgaFAuI=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-1f2VBNBuM3an7NzxCM5XQA-1; Tue, 24 Oct 2023 03:08:07 -0400
X-MC-Unique: 1f2VBNBuM3an7NzxCM5XQA-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-53f8893ddbdso855264a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 00:08:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698131286; x=1698736086;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e2ft1iIUeqg/aot+9+OZB9Lfvws+RDiPr3cR/Bz0A1g=;
        b=ZZ60yNmN8ceZe679esdIYnGZgKUzmma+JTP4oFP1kgj8DoG9umwiodobjPCiOxO3Yw
         861KlabdOfquoAbw77t7ilrTIcAqYiqPbdOpZ+IKg1msQaq5QhJ5rnDmRJXsfOsOwYLD
         9YRV5RnKvlwuijPVitZOSNpzprdKLrodZHK4VhX6eCcajvXZEpkyl7cy/MM3gAz7j3Lc
         fAN7BewxPjQal3C6RrMDcj9uil34VEKZye3fToKmDM/XsN5dVM59QRkawN+6cWZEf2IE
         aMoc+hcaTYQc0cXhx8BQWx/xg70vXBCnxW1TM1iMQz8K/NuUvBYNZc1dJtgGOsayJW8t
         pcuw==
X-Gm-Message-State: AOJu0YxipW8lpbuh36WZHkYPTlRMuEhtBNhi7bEf1ew0pQ5qBUzl9P1l
        BdUe5Z0tu61732LilGng++nFKQNeHg4mjZFgaE0N93gV/91gekIcKmOEIGMBxarNveURMl4e79F
        V7HtjGM6lFs/ArtLC7hlo14W7
X-Received: by 2002:a17:906:74d9:b0:9c3:9577:5638 with SMTP id z25-20020a17090674d900b009c395775638mr7384965ejl.0.1698131285919;
        Tue, 24 Oct 2023 00:08:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGPaCM7KIuJtAaMw46pyDZhEwtqHzRUEKzb1sBmdVRk3Pp0xGYZFtcg3FeMCJOb4OO+lA5OVA==
X-Received: by 2002:a17:906:74d9:b0:9c3:9577:5638 with SMTP id z25-20020a17090674d900b009c395775638mr7384951ejl.0.1698131285585;
        Tue, 24 Oct 2023 00:08:05 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-237-0.dyn.eolo.it. [146.241.237.0])
        by smtp.gmail.com with ESMTPSA id 20-20020a170906019400b00992b8d56f3asm7794023ejb.105.2023.10.24.00.08.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 00:08:04 -0700 (PDT)
Message-ID: <69c50d431e2927ce6a6589b4d7a1ed21f0a4586c.camel@redhat.com>
Subject: Re: [PATCH net v3 3/3] sock: Ignore memcg pressure heuristics when
 raising allocated
From:   Paolo Abeni <pabeni@redhat.com>
To:     Abel Wu <wuyun.abel@bytedance.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Shakeel Butt <shakeelb@google.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 24 Oct 2023 09:08:03 +0200
In-Reply-To: <20231019120026.42215-3-wuyun.abel@bytedance.com>
References: <20231019120026.42215-1-wuyun.abel@bytedance.com>
         <20231019120026.42215-3-wuyun.abel@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-10-19 at 20:00 +0800, Abel Wu wrote:
> Before sockets became aware of net-memcg's memory pressure since
> commit e1aab161e013 ("socket: initial cgroup code."), the memory
> usage would be granted to raise if below average even when under
> protocol's pressure. This provides fairness among the sockets of
> same protocol.
>=20
> That commit changes this because the heuristic will also be
> effective when only memcg is under pressure which makes no sense.
> So revert that behavior.
>=20
> After reverting, __sk_mem_raise_allocated() no longer considers
> memcg's pressure. As memcgs are isolated from each other w.r.t.
> memory accounting, consuming one's budget won't affect others.
> So except the places where buffer sizes are needed to be tuned,
> allow workloads to use the memory they are provisioned.
>=20
> Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
> Acked-by: Shakeel Butt <shakeelb@google.com>
> Acked-by: Paolo Abeni <pabeni@redhat.com>

It's totally not clear to me why you changed the target tree from net-
next to net ?!? This is net-next material, I asked to strip the fixes
tag exactly for that reason.

Since there is agreement on this series and we are late in the cycle, I
would avoid a re-post (we can apply the series to net-next anyway) but
any clarification on the target tree change will be appreciated,
thanks!

Paolo

