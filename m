Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F0E37E4973
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 20:55:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234501AbjKGTzp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 14:55:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjKGTzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 14:55:43 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6425BD7A
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 11:55:41 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1cc5b6d6228so41116115ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 11:55:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699386941; x=1699991741; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HNeFqgo6zpROkihy0ShoA85fAr1c1+bU52BjgzWcK1o=;
        b=Yx/c11xV+iyISUNC4tjBoSSI8tDR682FVRusZqHd8SLKwKdyfBTM8w5vQkcXgknLJ5
         jAgQELvmzCuVCKasvH6kMnPtHvprVKl7yqS82mCfrB/C94OMNdAzRAu1PvRDjHy91cqI
         QScGcCYchxw00U+ge59I8ZKuiL3/85122I5rI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699386941; x=1699991741;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HNeFqgo6zpROkihy0ShoA85fAr1c1+bU52BjgzWcK1o=;
        b=NSVbmLLwCR+oMnieIi7v9sb74rX35lpIfJmTmtH/aRpaaHKdbZcwd2xcf/XqzrxKxU
         svA14sw58892Ap7HoRxurB6X2NroQ+BJ4OC+q1M+Sa5kjPX/3YygtK/WkSrFpXHZYxLR
         z4AIYwkdSj49YC1t9XTcNNWE7w3/idOz4ZcQGkKuI/BDdZjynYjRKNYEG8V0dQohTmoq
         K90Jxxs9ldtnxHywsbAfY4E5BaBf6PRvx40dcwJxbQ8lsVOeF2Fl/NiAc9E7xoV2QG9T
         UALqRI0lWrYNt/KlZ1m0G1ywHsL+Z+2RFNZSwrGF57dz+pnrQ84q/Ikp5TatV6sVw9Y9
         r1NA==
X-Gm-Message-State: AOJu0YxudEsMA7tt13mvRKVu+rzEIoofaT8cfQBnlBgx7TFi2IHHxuaL
        PfYybIXfhP7TtEhQbXWlDBCfVg==
X-Google-Smtp-Source: AGHT+IEZgybC45XGlQUGbU637Xhd/YQognaCWgtAXzdYdCdXOmVngLWoQt1kbfTCkOpNfx5sZXCftA==
X-Received: by 2002:a17:903:2282:b0:1cc:ee07:1654 with SMTP id b2-20020a170903228200b001ccee071654mr35008plh.14.1699386940686;
        Tue, 07 Nov 2023 11:55:40 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id jw24-20020a170903279800b001cc3a8af18dsm209511plb.60.2023.11.07.11.55.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 11:55:39 -0800 (PST)
Date:   Tue, 7 Nov 2023 11:55:38 -0800
From:   Kees Cook <keescook@chromium.org>
To:     j.granados@samsung.com
Cc:     Luis Chamberlain <mcgrof@kernel.org>, willy@infradead.org,
        josh@joshtriplett.org, Eric Biederman <ebiederm@xmission.com>,
        Iurii Zaikin <yzaikin@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        John Stultz <jstultz@google.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Petr Mladek <pmladek@suse.com>,
        John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Balbir Singh <bsingharora@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: [PATCH 05/10] seccomp: Remove the now superfluous sentinel
 elements from ctl_table array
Message-ID: <202311071155.EE9C0FBF@keescook>
References: <20231107-jag-sysctl_remove_empty_elem_kernel-v1-0-e4ce1388dfa0@samsung.com>
 <20231107-jag-sysctl_remove_empty_elem_kernel-v1-5-e4ce1388dfa0@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231107-jag-sysctl_remove_empty_elem_kernel-v1-5-e4ce1388dfa0@samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 07, 2023 at 02:45:05PM +0100, Joel Granados via B4 Relay wrote:
> From: Joel Granados <j.granados@samsung.com>
> 
> This commit comes at the tail end of a greater effort to remove the
> empty elements at the end of the ctl_table arrays (sentinels) which
> will reduce the overall build time size of the kernel and run time
> memory bloat by ~64 bytes per sentinel (further information Link :
> https://lore.kernel.org/all/ZO5Yx5JFogGi%2FcBo@bombadil.infradead.org/)
> 
> Remove sentinel element from seccomp_sysctl_table.
> 
> Signed-off-by: Joel Granados <j.granados@samsung.com>

Acked-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
