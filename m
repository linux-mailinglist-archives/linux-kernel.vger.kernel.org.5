Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D77F775FE3
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 14:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231989AbjHIMy4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 08:54:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjHIMyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 08:54:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BB611FFE
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 05:54:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E78276399E
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 12:54:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E99B9C433C7;
        Wed,  9 Aug 2023 12:54:51 +0000 (UTC)
Date:   Wed, 9 Aug 2023 08:54:49 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Sven Schnelle <svens@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tracing/synthetic: use union instead of casts
Message-ID: <20230809085449.453b632a@gandalf.local.home>
In-Reply-To: <20230809071459.2004931-1-svens@linux.ibm.com>
References: <20230809071459.2004931-1-svens@linux.ibm.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  9 Aug 2023 09:14:59 +0200
Sven Schnelle <svens@linux.ibm.com> wrote:

> --- a/kernel/trace/trace.h
> +++ b/kernel/trace/trace.h
> @@ -1295,6 +1295,16 @@ static inline void trace_branch_disable(void)
>  /* set ring buffers to default size if not already done so */
>  int tracing_update_buffers(void);
>  
> +struct trace_dynamic {
> +	union {
> +		u8				as_u8;
> +		u16				as_u16;
> +		u32				as_u32;
> +		u64				as_u64;
> +		struct trace_dynamic_info	as_dynamic;
> +	};
> +};
> +

No need to create a structure around a single element union. Also, I would
like to name it for what it is for.

union trace_synth_field {
	u8				as_u8;
	u16				as_u16;
	u32				as_u32;
	u64				as_u64;
	struct trace_dynamic_info	as_dynamic;
};

Other than that, the patch looks good. Although I still need to test it.

-- Steve
