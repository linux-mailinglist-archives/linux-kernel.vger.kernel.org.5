Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33303801EAF
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 22:34:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231928AbjLBVe3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 16:34:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjLBVe1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 16:34:27 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6BAEE5
        for <linux-kernel@vger.kernel.org>; Sat,  2 Dec 2023 13:34:33 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-517ab9a4a13so1439574a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 02 Dec 2023 13:34:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701552873; x=1702157673; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZLyDJvxTAas36YBBDf/PjaQIfAeNkr7hpF36GzNdMaw=;
        b=HhHWXOEgmkx+Lle4PbqTWAgE0KdG45JToNHkLdsGrjdGZqNbxqw8kJrHygouAcqV+d
         owZ53Q5cVNkeHjlamz2xSsLdmrm4Dtg/GD9KPs8fVl/ZoW+uWRmfVtqde8T4aanFdzhp
         FQBhZJxkxPT/I7q2DI/ix+HmsiigJ4epjSp+M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701552873; x=1702157673;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZLyDJvxTAas36YBBDf/PjaQIfAeNkr7hpF36GzNdMaw=;
        b=DStVQdzbhPuc+nhj6i7L24ObuDMcXvtAR48zz+4c92kifK5mG9XtEX0UgIZmyuZsnp
         fPM6b9WXCiq5zPD6SfPgGIKOim69NSu8NSTnu29wyLPBwHgPzQ7+a5LaWl28sOGQH+Qe
         kphO6L/nUSJ2tQWbATYsdwAC5W6uoSC1aNkz+f0kZTqyoi/cIxf2LfJ7QG8i5VzOHgsA
         a0JgbNHeVPHZvgiXPPSNhFbGBpCZxeLAWWssCjELR/BFQu4ka4JMDdVmldiN8uEjvakx
         G9kkLjTm5GlPxAUlR6Pm1SSe4Ll1lZiKrs29S5bz3YnDSy8Iy+YfMsv8xl6uQ4L6zsB8
         FLgQ==
X-Gm-Message-State: AOJu0Yy5FBfiQ0UOBgKBu3mg5L/KJUwPNOb4vU4sbKgWmvNT/7iktbWT
        7Bxu3Rk+zyT99+5waqXoOEEZDw==
X-Google-Smtp-Source: AGHT+IH97qo71rxWkVbqooHXWm3am4MyA5QABdbmX40pWHK3KuNMNSgUPUEc1HYAA1B9MAWZgdr71Q==
X-Received: by 2002:a17:902:720a:b0:1d0:6ffd:e2ef with SMTP id ba10-20020a170902720a00b001d06ffde2efmr1311703plb.137.1701552873337;
        Sat, 02 Dec 2023 13:34:33 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id d9-20020a170902aa8900b001cfc50e5ae9sm5626968plr.78.2023.12.02.13.34.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Dec 2023 13:34:32 -0800 (PST)
Date:   Sat, 2 Dec 2023 13:34:32 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Christian Brauner <brauner@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-fsdevel@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 3/5] fs: Add DEFINE_FREE for struct inode
Message-ID: <202312021331.D2DFBF153@keescook>
References: <20231202211535.work.571-kees@kernel.org>
 <20231202212217.243710-3-keescook@chromium.org>
 <20231202212846.GQ38156@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231202212846.GQ38156@ZenIV>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 02, 2023 at 09:28:46PM +0000, Al Viro wrote:
> On Sat, Dec 02, 2023 at 01:22:13PM -0800, Kees Cook wrote:
> > Allow __free(iput) markings for easier cleanup on inode allocations.
> 
> NAK.  That's a bloody awful idea for that particular data type, since
> 	1) ERR_PTR(...) is not uncommon and passing it to iput() is a bug.

Ah, sounds like instead of "if (_T)", you'd rather see
"if (!IS_ERR_OR_NULL(_T))" ?

> 	2) the common pattern is to have reference-consuming primitives,
> with failure exits normally *not* having to do iput() at all.

This I'm not following. If I make a call to "new_inode(sb)" that I end
up not using, I need to call "iput()" in it...

How should this patch be written to avoid the iput() on failure?
https://lore.kernel.org/all/20231202212217.243710-4-keescook@chromium.org/

-Kees

-- 
Kees Cook
