Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D35D37A53AF
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 22:15:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbjIRUPv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 16:15:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjIRUPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 16:15:48 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74476B6
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 13:15:42 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id ca18e2360f4ac-77dcff76e35so62527739f.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 13:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1695068142; x=1695672942; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hjmj7plkbnOlDMjCra3y3a09oBx1pW45VyaUM21Y7AM=;
        b=VvO4wGnHhG/8yjHEZ+ktbqa+0WjjZOpfuhYQhzYHwRmO3Tfs5PrCeFVIGb+RuvuoVS
         o3uXe1boJTJycm6bAbDMp6Hd/tbkXt9Cuuw7LO1rqVIDX9I3NM4rla0o6VeMpKwUW0jl
         ANojvXB0M+qOAVYToTPvF0TDjLZd1axval+XzTlrF496/Tayu32+0GypnTJJ2bCtd50l
         aCB90HkTSL4VvjqbxYDpq0q7IbdGjjPWb9m6D8PIvCl32b55qUTrUmuYrtBXpaF9PX3V
         NkzmW68hNHy/OLqhwsh1kVB+mDibMa3Zi2NIwDE8cet2LPMT06TB+jpN78sj2ENKx4ww
         T2IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695068142; x=1695672942;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hjmj7plkbnOlDMjCra3y3a09oBx1pW45VyaUM21Y7AM=;
        b=P9wUQbMqqSDVR6ExJNB9MWcOzad3Pd8Ay9e2azdKwcW6VzDgG683ojmT4XF/QBfpXR
         b9DLRpDc8Ur7sHFt1Nq0itFfHBt5aF+4xSg6dji5U5T+4lLSfTY+6n4yIcQ2FNd+MKEO
         1mjnebMX/xC0KX82msNrcglZ6IFZroaW/ZNxvhweaH6qmGmNvJHCDmIihUAdcVwhSRMt
         wWLOW7cwatrwAekS6eDRlZuvIlpIE7aeS91W162QNbJ8WSXV7z8SuzYzQLOlMZJYVjLB
         eazPqNjkIQ7lfJHaH2a5Lz1zXCzMxu29MZmJRMtQx5ZGcaaBW7EuO8lO0jjNnSIikHar
         rAWQ==
X-Gm-Message-State: AOJu0YztZ9MD59hEKEbxRSpW/Qs2sZbzaSZycJGC3yoUOVdkW+oiJqZX
        AhBJtmBIP66fgU4S24bJrNyW2A==
X-Google-Smtp-Source: AGHT+IF6ZrFTRNOlSrFYsTgxKrHJFPd36vms08lvaqfmFTt5ikRLAhqAeHlPU/sHGBbXLkoXXETm0w==
X-Received: by 2002:a92:907:0:b0:34f:6e08:d6a3 with SMTP id y7-20020a920907000000b0034f6e08d6a3mr10411038ilg.0.1695068141828;
        Mon, 18 Sep 2023 13:15:41 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id o20-20020a056638125400b0042b451aa95esm2945116jas.150.2023.09.18.13.15.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 13:15:40 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     tj@kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kemeng Shi <shikemeng@huaweicloud.com>
In-Reply-To: <20230914091508.36232-1-shikemeng@huaweicloud.com>
References: <20230914091508.36232-1-shikemeng@huaweicloud.com>
Subject: Re: [PATCH] block: correct stale comment in rq_qos_wait
Message-Id: <169506814063.372099.2658807658177703138.b4-ty@kernel.dk>
Date:   Mon, 18 Sep 2023 14:15:40 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-034f2
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 14 Sep 2023 17:15:08 +0800, Kemeng Shi wrote:
> The rq_qos_wait calls common wake-up function rq_qos_wake_function to get
> token. Just replace stale wbt_wake_function with rq_qos_wake_function in
> comment.
> 
> 

Applied, thanks!

[1/1] block: correct stale comment in rq_qos_wait
      commit: e599ed7866cd804ca15de7a92f7f629944cc278d

Best regards,
-- 
Jens Axboe



