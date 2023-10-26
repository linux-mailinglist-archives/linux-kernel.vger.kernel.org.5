Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3F7C7D88FE
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 21:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231596AbjJZTfu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 15:35:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbjJZTfs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 15:35:48 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C86610E
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 12:35:45 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1cab2c24ecdso10323245ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 12:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1698348945; x=1698953745; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IQC4A/sL4XoeDc7l3OjE8DP+73M4y+QZaaN7R7Z8PCQ=;
        b=Aywc3mCW9NW0AMC6WgUz95gu5oOfmutaPs4DHPoAfIJnUt8e5xK8aZiSjbq4BjtS6m
         Um4z9WCPAd2qYuDxuI0/pEzpzvshgTjURFCl8x36stzu2DhXmFDBWrhA5yaUN5Zr8sgm
         JBOEWHij/NraEObIV6BWKo1s9FbKUF5+nn/qA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698348945; x=1698953745;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IQC4A/sL4XoeDc7l3OjE8DP+73M4y+QZaaN7R7Z8PCQ=;
        b=a0lcWwUF3UeuI//2ZH1h6howayBDCbdWsedu5qjoyzk7Qm1AfwzADT1SgaFNJtr8Ya
         66jT0wagU4ldda26/S6x9BUmmMRU+ZMNkuF75kYnlsdJUGUpEnpsbro4OTyfk6HCmtXD
         Q6t+nz6ShuyZaYmMQ3NxJENMS6Se2sN/aGFw7FIJVlYAnHkd41jJiltc2BNNfqD5sKqz
         bh2ffdtH+VqNcH3FeYiQKzGg+CUhFbp22/HvkJQslRzinKbX6mwgiBv+26Ra0qDKrayz
         pF/udIUHcqm5oSoZYEMviUPBciYAycdcs9fkvthhUwCK6pGsjIjMPeZh1WFSCNjsobCk
         32tQ==
X-Gm-Message-State: AOJu0YwhXtr880Utt7qCmU4fl0L4V96bvmmXKd3BXwa+fYCmBJ0L3cva
        +4/2cjsd/DgNyvQyuIHjoCvQCA==
X-Google-Smtp-Source: AGHT+IF5LDmYM98HgrrDpR0APpEt3rwu9iztxBirzFeXmCAP46nFRKhSnMjIOUGuff1tVeQB7T13qQ==
X-Received: by 2002:a17:903:1105:b0:1c9:faef:5765 with SMTP id n5-20020a170903110500b001c9faef5765mr603014plh.5.1698348944845;
        Thu, 26 Oct 2023 12:35:44 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id 10-20020a170902c14a00b001b9d95945afsm46208plj.155.2023.10.26.12.35.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 12:35:44 -0700 (PDT)
Date:   Thu, 26 Oct 2023 12:35:43 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>,
        Justin Stitt <justinstitt@google.com>,
        Kent Overstreet <kent.overstreet@linux.dev>,
        Petr Mladek <pmladek@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Yun Zhou <yun.zhou@windriver.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        linux-trace-kernel@vger.kernel.org,
        Yosry Ahmed <yosryahmed@google.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] seq_buf: Introduce DECLARE_SEQ_BUF and seq_buf_cstr()
Message-ID: <202310261233.716843B8@keescook>
References: <20231026170722.work.638-kees@kernel.org>
 <20231026133850.138d5415@gandalf.local.home>
 <202310261050.A621A7F121@keescook>
 <20231026140247.3a3c68e4@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231026140247.3a3c68e4@gandalf.local.home>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 26, 2023 at 02:02:47PM -0400, Steven Rostedt wrote:
> On Thu, 26 Oct 2023 10:54:26 -0700
> Kees Cook <keescook@chromium.org> wrote:
> 
> > > Do we really need to call it _cstr? Why not just have seq_buf_str() ?
> > > 
> > > I mean, this is C, do we need to state that in the name too?  
> > 
> > I'm fine either way. I did that just to make the distinction between our
> > length-managed string of characters interface (seq_buf), and the
> > %NUL-terminated string of characters (traditionally called "C String" in
> > other languages). And it was still shorter than "seq_buf_terminate(s);
> > s->buffer" ;)
> 
> Do you believe that people might get confused with it as seq_buf_str()?
> 
> Can you envision that we would want a seq_buf_str() and seq_buf_cstr() that
> do something different?

No, I see your point. Like I said, I don't care either way. I was just
explaining why I did it that way. "string" means a lot of things to
different people. "C String" is unambiguous, and I try to be unambiguous
whenever possible. :)

I'll send a v2 as seq_buf_str()...

-- 
Kees Cook
