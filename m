Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C17AC7E9E57
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 15:15:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbjKMOPU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 09:15:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbjKMOPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 09:15:17 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78934D59
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 06:15:14 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-5b79f96718eso4284669a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 06:15:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699884914; x=1700489714; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5Mk8WDCUgjWBxKl9jlq4aL9xPelNIJ1UBxyFJ0gNzaY=;
        b=FG2IoRzEewI4k2LWm15gI1o7CkkGFPwpe4Wa0/E+67GS+xmRtJ00rLi2R53n+M8DKx
         KMOI697F19hsMfr5LST+xV6txxs42puFMmEZUX5/3DR7ylIPPlzq1nVRKVOyE9Lo+qWB
         UXAQz97yOcbK+pzU4eYEDKF5GcjPZlXEPCHPB7vK8O9YhRhP1D7F9Tr4QqvR/pRJyacW
         KFV4Y5GcxLIgANFq+qV1eNNwDVk80vuIFWDMR64wqbO2HNOpNfI8DAqPBqbFkuXOsniL
         YV2SMuvAO6xsjyEh8rIucwI6dJ7DIVt/h7a4bP+2V0ITmhvPSCoYzZt+u65kv6I2v9OU
         VP4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699884914; x=1700489714;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5Mk8WDCUgjWBxKl9jlq4aL9xPelNIJ1UBxyFJ0gNzaY=;
        b=ZOANfdj0+UG1i0ESbU7RizEOmyozVn4XpZQPoytVPlUWTTgCKQapc7iO2tLT9IZGdm
         CU1LyXDHYI4Chk3eiD8oLFJLOIj3NKEFMZ5ej7yBUHZwoFh/l6DHCCnaJ7D3RbwuzIfy
         JLXXIqyVkOZNsw8qms2XWwlEThHwZ/jMzvkRyrkCA4j5k8lE/neQfanL24yhcFYMn1en
         nW8JwABB/rSOm8OaXVNMFOTAUfeTaJDM9PPmJbtQMvHBLrH0+Dr1Xs4u4XkMg9dDaggr
         a+1gUJX81akGugicjpmN+2L3f6QGDrzzq5ToDfmXF53d9Nz1BjLCDJlsH1pOhJemH0WC
         E2UA==
X-Gm-Message-State: AOJu0Yxun37NGOL6Ck8GP4pF0wq0PhuZ7/N/r1sYzU/bmx/lIu314MlF
        untmksUdWJw3WSm7uqq965z0syg=
X-Google-Smtp-Source: AGHT+IG66n8uTzzgWG+eBzgEiAwfulvDnCo3bWDOeIZTHC184x4dKHsFANPV/MPQIGH5HlsQ2dl7WGA=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a05:6a02:912:b0:5bd:839e:caf1 with SMTP id
 ck18-20020a056a02091200b005bd839ecaf1mr3096512pgb.3.1699884913884; Mon, 13
 Nov 2023 06:15:13 -0800 (PST)
Date:   Mon, 13 Nov 2023 06:15:12 -0800
In-Reply-To: <20231113031812.3639430-1-xwlpt@126.com>
Mime-Version: 1.0
References: <20231113031812.3639430-1-xwlpt@126.com>
Message-ID: <ZVIvcM3BDOvKGpwa@google.com>
Subject: Re: [PATCH] bpf: Get the program type by resolve_prog_type() directly
From:   Stanislav Fomichev <sdf@google.com>
To:     Wenli Xie <xwlpt@126.com>
Cc:     martin.lau@linux.dev, ast@kernel.org, daniel@iogearbox.net,
        song@kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wenli Xie <wlxie7296@gmail.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/13, Wenli Xie wrote:
> From: Wenli Xie <wlxie7296@gmail.com>
> 
> The bpf program type can be get by resolve_prog_type() directly.

Can we have more details in the change log about why using
resolve_prog_type is better?

Please also take a look at Documentation/bpf/bpf_devel_QA.rst on
how to target the right tree ([PATCH bpf-next]).
