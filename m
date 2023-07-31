Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1701476A52F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 01:52:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbjGaXwa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 19:52:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230342AbjGaXwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 19:52:25 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B7F91736
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 16:52:24 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1bb81809ca8so40262475ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 16:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690847543; x=1691452343;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QY6TrGgRbolQvDwJetzrA5+Cwmb7LM9vP/Acoe/k5eA=;
        b=GJBsZXr0HBXQgvZEWM5ORpxG9Wtr/vc6FLEJwGWTg2FpH2NKbZHTwQKDKrK2QbQ1jS
         ggtPel5QGmViGG/rj0anM0DcAWFGHoD4xjVVJmcvucGaAzy59th6b1uyVG54uoCp+9Fm
         LIKgX5m1MhwiSXubCvSKn7hcdy7D0vBt1IZnK2eWB/UzVvUBXo24m4Ic9M5T8jHygrja
         pMJ4LhrE5/MesoWcxSKb4eXpIOpgXrYbJR3jQeyTg3LrSNI/yLI7YgS/cQs3bvh2QoA5
         ABcFb+yyPjqsHz2albEkQzzDMZsLL40rjD5OdjPwoP4dnZMXRRH2fHGKSF8H+CeWHk50
         0VKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690847543; x=1691452343;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QY6TrGgRbolQvDwJetzrA5+Cwmb7LM9vP/Acoe/k5eA=;
        b=OcW7L642e/Ir3wwk/IxvsHvQLOdZzukEpLR0DccZP6g4MKVV0TtAU9zcvHQbLhHe9d
         9YRexY+GvpL3BqJWOhC/Oy6LnUNqPITpQG+pQ4Ri4ZoTm3HpRjio/XKCaxVgrZ5OTH3t
         K8bfncccJeEFYADIe4WikoeaXpLA0zfx3akbQdpmnqeiXiD+TT+lPRn9ekxEgf1MuI5M
         s697OJOqS6KHJr9ZGUixU223HvlUzlcgYUwIMmgjTHJNsV1wVyJb3cPZppu4KEhGGFaU
         fmxyBByvUjfi+HR8MfSIic7lLPSTEIFJbtBFtmc0v71fiAzTUnAUGBV3HhTyufrCeMhN
         vrKA==
X-Gm-Message-State: ABy/qLZlj/c3EwPkXeCT05FZ6fWKdhc1V79upySOoJ8tquS2tI3chnJh
        0o/cmXheZ627wS1Y4mX8yhE=
X-Google-Smtp-Source: APBJJlHVP+HYHXV462gHbEjQ5dM5RjCRJlym6+hpwWwxI6hBoa9GFDNTl8Gz2AL8+rpRV68ys60E3A==
X-Received: by 2002:a17:902:ea0d:b0:1b8:6cac:ffe8 with SMTP id s13-20020a170902ea0d00b001b86cacffe8mr12773588plg.51.1690847543492;
        Mon, 31 Jul 2023 16:52:23 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:4a3a])
        by smtp.gmail.com with ESMTPSA id iw13-20020a170903044d00b001b0358848b0sm4052701plb.161.2023.07.31.16.52.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 16:52:23 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 31 Jul 2023 13:52:21 -1000
From:   Tejun Heo <tj@kernel.org>
To:     K Prateek Nayak <kprateek.nayak@amd.com>
Cc:     Sandeep Dhavale <dhavale@google.com>, jiangshanlai@gmail.com,
        torvalds@linux-foundation.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com,
        joshdon@google.com, brho@google.com, briannorris@chromium.org,
        nhuck@google.com, agk@redhat.com, snitzer@kernel.org,
        void@manifault.com, kernel-team@android.com
Subject: Re: [PATCH 14/24] workqueue: Generalize unbound CPU pods
Message-ID: <ZMhJNZLWQHInDf4e@slm.duckdns.org>
References: <20230519001709.2563-1-tj@kernel.org>
 <20230519001709.2563-15-tj@kernel.org>
 <CAB=BE-S=cxewXu7nqJY1DC5w9Bapar_C0cTjpZOQ-Qd5GGwYyw@mail.gmail.com>
 <c307ba94-0d8c-3cbf-19da-44ee31751428@amd.com>
 <ZIEBB-A1arYKSK2P@slm.duckdns.org>
 <fb3461cd-3fc2-189a-a86b-c638816a2440@amd.com>
 <ZIJbMQOu_k07jkFf@slm.duckdns.org>
 <d686347e-f76c-7f9c-3f1a-f4326f5167ca@amd.com>
 <ZKW4374Xc6YrRrEW@slm.duckdns.org>
 <4bb4c12b-4f8d-1069-6fe8-fe256292a763@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4bb4c12b-4f8d-1069-6fe8-fe256292a763@amd.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, Jul 11, 2023 at 08:32:27AM +0530, K Prateek Nayak wrote:
> > Yeah, that's a bit surprising given that in terms of affinity behavior
> > "numa" should be identical to base. The only meaningful differences that I
> > can think of is when the work item is assigned to its worker and maybe how
> > pwq max_active limit is applied. Hmm... can you monitor the number of
> > kworker kthreads while running the benchmark? No need to do the whole
> > matrix, just comparing base against numa should be enough.
> 
> Sure. I'll get back to you with the data soon.

Any updates? I'd like to proceed with the patchset as it helps resolving
problems others are reporting. I can try to reproduce the results too if you
can share more details on how they're run.

Thanks.

-- 
tejun
