Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3046575555F
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jul 2023 22:40:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232498AbjGPUkT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 16:40:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232469AbjGPUkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 16:40:17 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA926BA
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 13:40:16 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-3143b72c5ffso3999577f8f.3
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 13:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1689540015; x=1692132015;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bNDET4DfGLSfGvcldlobvVfUD/4s8WSs8nqQY8xJlBc=;
        b=K+RZwWRcN8Jo6yczgp4Av0I3kQqwyvlh0I5npmbkyBPS/EdqUhJf6ra2p14FZrsfTu
         fEEFRfeeEKnMpVFMCF4ByfYXRWbUckGJB4e3DwnMXONSZgPPRO1GiDQdam+kGlYmrE21
         hEj+kCU/8YJ9pSpcvWwWRl5Ty2AkfyKFAGZ18=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689540015; x=1692132015;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bNDET4DfGLSfGvcldlobvVfUD/4s8WSs8nqQY8xJlBc=;
        b=MXFbRwR2EcnrtwJLSOpn2iLzu9JArT50cybZ0xx2DG/65nfZALvdg0RBSlYLxzfv3N
         Qkw+7vRuZy8+6RKzPf61E508fYh54wDHjop1oHSA+PtiJaMyaObEHoKmlAZPD6z5Fdbl
         jyknkJlQ4AwUpa0L/DwjdxjdeuLwyrigR1A+LrSS5OOMcp0ve3ckf/L5HQLAisd7crXM
         jWYgSqodZXyxk9DCmJfLySm4H/DbMyTzAF9kq9giepBnMAuO/RyrCbs9IRrOTXpm+0KI
         6ncnOmU+agxzgO+ujGyOLXPTrxzyqvNI0UtqhpUvpVDy8QXxm4LhCKCPibBDZzfClv/E
         eOQw==
X-Gm-Message-State: ABy/qLZ+xg2TlHpF8am3iHw+vqVI4ejAXeJe+0VK9bTOg0CBsSpf+hVp
        V+08uWWJpCHJ5zbLyC9iDgAcjpCR0LGtvaaWQscJBg==
X-Google-Smtp-Source: APBJJlG1LMtTuaTMv9WoWzbRQEMI7H4K6I72gbhKGiHMoO/QpxX5vNOqVOvAZuH9XcG7tr+EizCWHA==
X-Received: by 2002:a5d:42c8:0:b0:311:1b8a:b70e with SMTP id t8-20020a5d42c8000000b003111b8ab70emr11141891wrr.66.1689540014695;
        Sun, 16 Jul 2023 13:40:14 -0700 (PDT)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id w24-20020aa7cb58000000b0051e0f8aac74sm8959877edt.8.2023.07.16.13.40.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Jul 2023 13:40:14 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-51de9c2bc77so5003402a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 13:40:14 -0700 (PDT)
X-Received: by 2002:a50:ee97:0:b0:518:7a40:b75e with SMTP id
 f23-20020a50ee97000000b005187a40b75emr11562286edr.25.1689540013798; Sun, 16
 Jul 2023 13:40:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230716184204.GFZLQ5/DJ1+q8vpuuN@fat_crate.local>
In-Reply-To: <20230716184204.GFZLQ5/DJ1+q8vpuuN@fat_crate.local>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 16 Jul 2023 13:39:56 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiXp9YLB6wHOmc4rBJbd7j0gHgHZPHhUSPe-SAjJgmABQ@mail.gmail.com>
Message-ID: <CAHk-=wiXp9YLB6wHOmc4rBJbd7j0gHgHZPHhUSPe-SAjJgmABQ@mail.gmail.com>
Subject: Re: [GIT PULL] objtool/urgent for v6.5-rc2
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 16 Jul 2023 at 11:42, Borislav Petkov <bp@alien8.de> wrote:
>
> - Mark copy_iovec_from_user() __noclone in order to  prevent gcc from
>   doing an inter-procedural optimization and confuse objtool

This is painful.

Isn't there some way to mark the user_access_begin() itself so that
the compiler doesn't move it?

I've pulled this thing, but it does seem like we're chasing the
symptoms, not the deeper cause..

            Linus
