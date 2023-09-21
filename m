Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEAA47A9888
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 19:49:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbjIURtP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 13:49:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjIURtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 13:49:02 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 013944EEB
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:22:56 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id ca18e2360f4ac-79d1fbeeb41so47307739f.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695316976; x=1695921776; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=S5AedakdL2DLH5q3d3HZzw5TGtzo0LUkRg64X9X0CmA=;
        b=jdH6HI5wu3wmGby4XO7Qfy5+tWAYDkoZGZjRveeoew8BptDjcrhowC6osm6S1CReao
         oWrFDkoi35mmRfyOZMZEHlxg4vrLqxS1WjjEfZlbvsCotF4dtIEUi5uprmB6irsOGTS2
         KktbcP9Qh37DCsF6bJTpXRpVwg8j0sgdQ+IGs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695316976; x=1695921776;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S5AedakdL2DLH5q3d3HZzw5TGtzo0LUkRg64X9X0CmA=;
        b=blgjCUh6Yln+UEtk5Q5MGYOo5De8o6/2fAqh5pPgT8I8jQN84eNVijdHbAB4uAgouA
         Zns/A9aU9FUp0anBIGW3xwvmnND9yepxUwUzKmH2c+RNLBRwEQUSVN7TNHGhEgt+hmde
         vPwysDyqKEMv/Svfza9lNFn1orKpGkDMuMFpvCnvCj5+IDkQnqEq4ZjNkAs99tpTVG7h
         SPsxQYtiFx81M2o0yu5D3gDOzpnJXCBsvgs5zR31gc0N3kz++0oUvbxRKlod+v38/Owf
         hzPL8AhRwbP0kiN6WyWJ5tM9OSVAkdEu5ViNaqrWIHqa5iIuuDCkhOjQlEJvjHewSGTw
         n+AA==
X-Gm-Message-State: AOJu0YzXgcgaoC2Iwrue5n//1f+UY5jwBaiDD82dddsMTxoFs/Uo8yZs
        nua4VjIDNLcYlEIYYBYnIv2Q9rU4rzpSq8gXVtM=
X-Google-Smtp-Source: AGHT+IERXSy4m4mH5TGJa7AGzsKotnz36kLtI3hGmpWCOob4chs2fw0n4I7MSxFkjzmv+f360CFpmA==
X-Received: by 2002:a05:6a20:4323:b0:14c:c511:387d with SMTP id h35-20020a056a20432300b0014cc511387dmr5811097pzk.9.1695289478842;
        Thu, 21 Sep 2023 02:44:38 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:c489:1500:3f44:a59e])
        by smtp.gmail.com with ESMTPSA id ij27-20020a170902ab5b00b001bd41b70b65sm1027051plb.49.2023.09.21.02.44.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 02:44:38 -0700 (PDT)
Date:   Thu, 21 Sep 2023 18:44:33 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH printk v1] printk: fix illegal pbufs access for
 !CONFIG_PRINTK
Message-ID: <20230921094433.GB14418@google.com>
References: <20230920155238.670439-1-john.ogness@linutronix.de>
 <20230921021859.GA14418@google.com>
 <87led0f17b.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87led0f17b.fsf@jogness.linutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (23/09/21 09:19), John Ogness wrote:
> On 2023-09-21, Sergey Senozhatsky <senozhatsky@chromium.org> wrote:
> > I wonder if anyone really use !PRINTK kernels. Can we get rid
> > of CONFIG_PRINTK?
> 
> It is used. It is one of the big annoyances during the last several
> years of the rework. I get bug reports relatively quickly after breaking
> !CONFIG_PRINTK. The reports come mostly from the kbuild robots, but also
> from real people.

Right, that has happened to almost everyone who has ever submitted
patches to printk, even dramatically simpler than yours and Petr's
patches (e.g. my printk patches).

> If someone has limited space/memory requirements and does not care about
> dmesg, they can save a considerable amount of kernel size and memory by
> turning all that off. The problem right now is that !CONFIG_PRINTNK is
> horribly hacked together with dummy implementations and useless real
> functions that pretend to do stuff.

I was somehow thinking that prb is the biggest memory consumer on such
systems, but now that I looked at it, even on my very trimmed .config
the difference between PRINTK and !PRINTK is pretty huge:

./scripts/bloat-o-meter vmlinux.o.printk vmlinux.o.noprintk
add/remove: 79/643 grow/shrink: 235/3169 up/down: 30532/-1488150 (-1457618)
...
Total: Before=31118934, After=29661316, chg -4.68%

And !PRINTK doesn't even completely eliminate printk-s footprint.
All those temp buffers that are used for sprintf/printk are still
there. For example:

void mem_cgroup_print_oom_meminfo(struct mem_cgroup *memcg)
{
        /* Use static buffer, for the caller is holding oom_lock. */
        static char buf[PAGE_SIZE];
        struct seq_buf s;

	...

        memory_stat_format(memcg, &s);
        seq_buf_do_printk(&s, KERN_INFO);
}

in !PRINTK builds seq_buf_do_printk() doesn't do anything useful, yet
the buffer (and the code that fills that buffer) is (are) still there.

> After the rework we can work on splitting out the code based on
> functionality. If done right, it will be trivial to "implement"
> !CONFIG_PRINTK in such a way that changes to real code don't explode
> every time on !CONFIG_PRINTK.

Sounds good.
And sorry for the noise.
