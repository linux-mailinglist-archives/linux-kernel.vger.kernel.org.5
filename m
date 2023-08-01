Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D961576BB89
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 19:43:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231194AbjHARnW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 13:43:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjHARnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 13:43:19 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A417E1BC8
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 10:43:18 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-99bc512526cso922128766b.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Aug 2023 10:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1690911797; x=1691516597;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=f36gOBPIy1Zmguze7mrHnn3xV4XJM8s2rEorRuGLnXc=;
        b=Zi1hII0MO9R5yWLVXT8B+0SQ0LjH3M3E/oT4RuK3eRJyYEq7xNP84v3HGk/HUSDngL
         07/vNKIUsCHhOeYc6y1n4veCmp8wi9+Pgd3RqnsX57ItndaJ+Xb6fctJB3ewKB/eR9Ai
         QtQyVhVmYrV4Z6Oewnn40D5I9FK1HHwbOGKss=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690911797; x=1691516597;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f36gOBPIy1Zmguze7mrHnn3xV4XJM8s2rEorRuGLnXc=;
        b=Qgtfl+zBSafwvOJjjjX17oAn9FZlTbHk1GE4vsqANaLMkflHB2niq2JSkmk+XmetWL
         vwlzxubWasTZNGMka45LAsAlkKxKfPHnGOY/cHIDVA98So2Cg0iu/badmritjIcQhd+X
         9nweYENePwsFk4A6wx1lzA5/OmWNOhx2yJHFW1BoNfWqMPTEyvi2ivIND4T4nUSoikEg
         C+uojeRpQWXU28FMT7hu8LsQTTNIcLj4/WkG+eCDGPqwcXSSfqH19Q0R852Vz0kvQL1B
         N0cYrs+p20uL8zLwuUeQT0qYwioOimskvy7jSf4Da3+D9KAUnvRlpecpJDKT2LzqJsxz
         qmhQ==
X-Gm-Message-State: ABy/qLbDP221s1MbIhyxxBgtCaR98h/1qdj3YOYHyGX5KIB9IMoZW+78
        f0dCy7OglFcDc/uOPak8ynkh8HLbQ/EIJpSgECoxUg==
X-Google-Smtp-Source: APBJJlFc3tECXtwdT1fGKtwv5Y7sZ3DeX9Zxcc5NxZqOazeNZ/DxzNWV68X6gHOVSrO26ZWckR39AVWL7lfgF5Y0rWM=
X-Received: by 2002:a17:906:649e:b0:987:16c6:6ff3 with SMTP id
 e30-20020a170906649e00b0098716c66ff3mr3243440ejm.38.1690911797040; Tue, 01
 Aug 2023 10:43:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230720091436.399691-1-yunlong.xing@unisoc.com>
In-Reply-To: <20230720091436.399691-1-yunlong.xing@unisoc.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 1 Aug 2023 19:43:05 +0200
Message-ID: <CAJfpeguygW3JY5L5d+87+V538hAWu2tL9Yksg5p-QMP3ppv13w@mail.gmail.com>
Subject: Re: [PATCH V3] ovl: fix mount fail because the upper doesn't have space
To:     Yunlong Xing <yunlong.xing@unisoc.com>
Cc:     amir73il@gmail.com, linux-unionfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhiguo.niu@unisoc.com,
        hongyu.jin@unisoc.com, yunlongxing23@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Jul 2023 at 11:15, Yunlong Xing <yunlong.xing@unisoc.com> wrote:
>
> The current ovlfs mount flow:
>
> ovl_fill_super
>  |_ovl_get_workdir
>     |_ovl_make_workdir
>        |_ovl_check_rename_whiteout
>
> In ovl_check_rename_whiteout(), a new file is attempted to create.But if
> the upper doesn't have space to do this, it will return error -ENOSPC,
> causing the mount fail. It means that if the upper is full, the overlayfs
> cannot be mounted. It is not reasonable, so this patch will omit this error
> and continue mount flow.

Wouldn't mounting without upper (two or more lower layers) work in this case?

Thanks,
Miklos
