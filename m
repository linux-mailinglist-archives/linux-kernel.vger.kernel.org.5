Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58F66803833
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 16:02:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233980AbjLDPCQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 10:02:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233612AbjLDPBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 10:01:55 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BC5C19B4
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 07:01:34 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1d0897e99e0so7410945ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 07:01:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701702093; x=1702306893; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=64XUqgnzPZUkswUFPk01oA+P1n2lZ7pVBNmHYBOAIo0=;
        b=p0qgkuQu5KRYhC+0YRCy4Ot/DYa8K+noopTX+/GvxCfMkeD0HJooxwVInXMigooYTN
         +rW7d4VjD2BWBSOc58ov2fF89N8bpdRwd17iIlJ6GKY9pSj8uxzDdqUyCy0MvOKR6nhN
         dS7ktHLlfe67T42MBbJzGQfnbBOqghXYRTDxULzn9msAXHUF+Mk2AOr1uM2HvzZmI1sx
         v5CUEGEK6oCuMFn8fuU6PviQF/KF8pSIcWCwj8qZY/XedhymMf99/EFVHVBVrcf3zZLZ
         mkqurrGu3hjUI++OeQPSBVWvSDzFA+n72woAvoSlU6sYtBbMGMWePMj/5E9Gkv/UaOv3
         KwDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701702093; x=1702306893;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=64XUqgnzPZUkswUFPk01oA+P1n2lZ7pVBNmHYBOAIo0=;
        b=Ft7VDL1wqDbg1yfwYVQ0UYuSWLwYtm58HHSZSOCVy+ycGEYpatRdMHA671JjWKY6N1
         o5Y4v7H6kG8/iutg1BVxDGSwI3zIXZgTIQamUMmPkSAf4Re8MnHcE22lb5a+Xm8HWxHE
         Aa7FFVh2mY7Acl7CD9Wo4DG1IlmfwaOckrsbJiM7ZKdqPNROObdskUzsVNc+yhPQhHdR
         UgGiRYTsiPeyR+T/ug+zapanMCtpkpKUIkiJXofy0mIrxHCAg1Hukk0AKzyjb87H4F2S
         GvEJcsdFnNWU0fzEiup+RlEOLJuOFd3s6XrUorWFt1CR2fqbpJj9FD8V3Qd6KPxHT1dY
         80fw==
X-Gm-Message-State: AOJu0YwmVlfDU5QzY2rcYPD9rNk5Ke8LtRd4UTI//m29cK/x22p60Tal
        s9BkvAOYXvKoEoxUnbA/MIhSuQ==
X-Google-Smtp-Source: AGHT+IE31qVPpGlL7fHktBNcQF6oBwE66qXE5z8UykyHueyEqcucPKSTSglGMHFLnen6oBooVrG5Zg==
X-Received: by 2002:a17:902:bd48:b0:1d0:aee3:59fd with SMTP id b8-20020a170902bd4800b001d0aee359fdmr977523plx.55.1701702093387;
        Mon, 04 Dec 2023 07:01:33 -0800 (PST)
Received: from google.com (170.102.105.34.bc.googleusercontent.com. [34.105.102.170])
        by smtp.gmail.com with ESMTPSA id l3-20020a17090270c300b001cf6783fd41sm8576755plt.17.2023.12.04.07.01.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 07:01:32 -0800 (PST)
Date:   Mon, 4 Dec 2023 15:01:29 +0000
From:   Carlos Llamas <cmllamas@google.com>
To:     Alice Ryhl <aliceryhl@google.com>
Cc:     arve@android.com, brauner@kernel.org, gregkh@linuxfoundation.org,
        joel@joelfernandes.org, kernel-team@android.com,
        linux-kernel@vger.kernel.org, maco@android.com, surenb@google.com,
        tkjos@android.com
Subject: Re: [PATCH v2 27/28] binder: reverse locking order in shrinker
 callback
Message-ID: <ZW3pyaWOmIZ9lrjL@google.com>
References: <20231201172212.1813387-28-cmllamas@google.com>
 <20231204115743.43597-1-aliceryhl@google.com>
 <ZW3mFp2Zo85N8pBE@google.com>
 <CAH5fLghSHt+8Q+1em=RsPmxW4hpuwoYbjO7A2fK18-vbWJm7fQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH5fLghSHt+8Q+1em=RsPmxW4hpuwoYbjO7A2fK18-vbWJm7fQ@mail.gmail.com>
X-Spam-Status: No, score=-13.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,FSL_HELO_FAKE,RCVD_IN_DNSWL_BLOCKED,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 04, 2023 at 03:47:22PM +0100, Alice Ryhl wrote:
> Ok. Feel free to remove or move the trace calls however it needs to be
> done and add my tag:

Sounds good. I'll remove the trace calls in a follow up patch since it
needs to be separate, thanks.

--
Carlos Llamas
