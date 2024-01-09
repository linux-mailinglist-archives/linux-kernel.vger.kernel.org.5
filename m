Return-Path: <linux-kernel+bounces-21488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5B48829066
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 00:01:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63DAA288ABF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 23:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3D413E470;
	Tue,  9 Jan 2024 23:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cRY83VTM"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA9A364D7
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 23:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-28beb1d946fso3095708a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 15:01:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1704841298; x=1705446098; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GR/ms3ctfSsOUjIPALp8Jd7xLfAi/c50pWgtGgQX/O4=;
        b=cRY83VTMoWd6qOPRGh+vBQzoHvwB6Kb/B59h4+sZ9nEXngc6fa3CiWY0EInO90ZUa+
         pLewU+mYkzpOHedfXnb3dzk252y1eq2H4gH/bzIYAjPTX+rvNLo91RL0uUugakmkcUg5
         I5+jHRHYmpFAWAEePSttL7aMvutsGKSfx/NXU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704841298; x=1705446098;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GR/ms3ctfSsOUjIPALp8Jd7xLfAi/c50pWgtGgQX/O4=;
        b=dryXYkHW68nghBadZlBKaEKi1KxdLLVuPcAgtjLHpa8ME2uv/b6ea7cMZbkdp/g4yJ
         qIIXeq0Mg5p8lZKSXcBh4wKvxS6j+ix9Ykz+xOUTckdws7FDYtbK1spDoQNDVrlYO05H
         7IILkz01O4362a50ZDRlcP2OVi1wmSibJyx5iuCchk72o/0Umr+8RWjIZeAmvySPgj9S
         009VWozCzERlcqu+5Nnq8mX/IL/B2HA8SFCkHaIC3ZLOY4nPopho3tfUgPQezWWQb8O7
         PQJ2A72n2H/mESMLid9UwfZMElaSnMueY0x3pG4ZjAPfXPx7xGbnD8FtTt2yIfRUSp5z
         Er8w==
X-Gm-Message-State: AOJu0Yzy6c/PPR97ezcVQFlTrkXa9ifCQGQesJR94wAJ62zeo1gDtuZ6
	30N4vVomAFzHARxeo64yvnXg+URyECtu
X-Google-Smtp-Source: AGHT+IEY9Ix5SjUd+2ybDs5lq+IUV5YSx5/dvVEQmA/K0Lydmc2CVqTv4/6oDxz4SjwLcsDqIp7aCQ==
X-Received: by 2002:a17:90b:2397:b0:28c:446c:8093 with SMTP id mr23-20020a17090b239700b0028c446c8093mr40661pjb.26.1704841298243;
        Tue, 09 Jan 2024 15:01:38 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id eu15-20020a17090af94f00b0028b845f2890sm19498pjb.33.2024.01.09.15.01.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 15:01:37 -0800 (PST)
Date: Tue, 9 Jan 2024 15:01:37 -0800
From: Kees Cook <keescook@chromium.org>
To: Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: lkp@intel.com, x86@kernel.org, bp@alien8.de,
	dave.hansen@linux.intel.com, linux-kernel@vger.kernel.org,
	oe-kbuild-all@lists.linux.dev, yu-cheng.yu@intel.com
Subject: Re: [PATCH] x86/shstk: Use __force when casting away __user
Message-ID: <202401091501.4EC0C8EAD@keescook>
References: <202401080003.duO4RmjK-lkp@intel.com>
 <20240109224619.1013899-1-rick.p.edgecombe@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240109224619.1013899-1-rick.p.edgecombe@intel.com>

On Tue, Jan 09, 2024 at 02:46:19PM -0800, Rick Edgecombe wrote:
> In setup_signal_shadow_stack() the kernel needs to push the restorer
> address to the shadow stack. This involves writing the value of the
> restorer pointer to the shadow stack. Since the restorer is defined as a
> __user in struct k_sigaction, the __user needs to be casted away to read
> the value. It is safe to do, because nothing is being dereferenced, and
> the de-__user-ed value is not stashed in an accessible local variable
> where it might accidentally be used for another purpose.
> 
> However, sparse warns about casting away __user. So use __force to
> silence sparse and add a comment to explain why it is ok.
> 
> Fixes: 05e36022c054 ("x86/shstk: Handle signals for shadow stack")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202401080003.duO4RmjK-lkp@intel.com/
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>

Seems fine to me. Thanks!

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

