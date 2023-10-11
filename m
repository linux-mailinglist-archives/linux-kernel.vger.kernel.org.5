Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE14F7C58B6
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 17:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346937AbjJKP7V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 11:59:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232812AbjJKP7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 11:59:16 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F249A7
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 08:59:15 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1c60778a3bfso59291775ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 08:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697039955; x=1697644755; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4EBM6QELn8ef1132SlMYb+b5mnbgclrgGpye79FUDoA=;
        b=kOdm9yp70z5nFVU+0weI+1eg23cIaj25FheAboD6zB4zEnLNzmjeqLn9MjCX/uc7v0
         C4/BKUtrAVht43EvwZkJQlK7bkNv49u2D9En5mm7ez9Bc55zKqCdToKmdE8T3Lw6rRpc
         IHTxWGl5ZiImOeL93KfhJVcgwO8RBsSsUtx1I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697039955; x=1697644755;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4EBM6QELn8ef1132SlMYb+b5mnbgclrgGpye79FUDoA=;
        b=KjIw0Wv7ErSIrPPsryUF1m7Kxpz+w2vetOLavGjX1VKlXKDq2hItQNkGrBC97Jk3kE
         9/rXiGPkgZOm/w9naJDe+OSvaQqywDd5lUj0KW5GjA0xALOPnAV1DzOL6oIOEK5iVXSC
         X1Hr441Md37MGq9bPs2ktOZLYmX49a8lKJl2d/KlgOYBxHkmwvySS6V4EEPz5JVHgk6L
         8eOwveSmqWcxH05c8kbhZBItImxe7hD0OF7vp9zXh9RUGqLGpueprO1occYChRA/irtp
         vm22OBnaUiBgDhz7MO/woQS5tV/3OR+qtfK8uoLlcJk4OxtZA/XI37SjIFxaoSbzJhzW
         P9Og==
X-Gm-Message-State: AOJu0YyXWSzkxCNZ4Vi2pu2cmSvHZMdW+BM22BxSU51pnw3L08qzF0wB
        o/CTbyAddnTo4SCM6gBqm6wbfg==
X-Google-Smtp-Source: AGHT+IFnhzRKmMknQABhdyRSLqQ/OlvokCEslWYllvOvh9DztjV2jkf9w6Z8A6ji3ZgSPg2SoS9dEQ==
X-Received: by 2002:a17:902:d716:b0:1c7:37e2:13e5 with SMTP id w22-20020a170902d71600b001c737e213e5mr18437786ply.21.1697039954910;
        Wed, 11 Oct 2023 08:59:14 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id u7-20020a170902b28700b001c46d04d001sm9681plr.87.2023.10.11.08.59.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 08:59:14 -0700 (PDT)
Date:   Wed, 11 Oct 2023 08:59:12 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Alyssa Ross <hi@alyssa.is>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Eric Biederman <ebiederm@xmission.com>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] exec: allow executing block devices
Message-ID: <202310110857.522FAFCA@keescook>
References: <20231010092133.4093612-1-hi@alyssa.is>
 <202310101535.CEDA4DB84@keescook>
 <87o7h5vcao.fsf@alyssa.is>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o7h5vcao.fsf@alyssa.is>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11, 2023 at 07:38:39AM +0000, Alyssa Ross wrote:
> Is it possible to have a file-backed memfd?  Strange name if so! 

Not that I'm aware, but a program could just read the ELF from the block
device and stick it in a memfd and execute the result.

-- 
Kees Cook
