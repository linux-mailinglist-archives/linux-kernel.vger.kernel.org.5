Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1CAA80115B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 18:21:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378635AbjLARGV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 12:06:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjLARGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 12:06:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FAE29A
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 09:06:26 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F7B2C433C9;
        Fri,  1 Dec 2023 17:06:24 +0000 (UTC)
Date:   Fri, 1 Dec 2023 12:06:48 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Jeffrey Hugo <quic_jhugo@quicinc.com>
Cc:     Krishna chaitanya chundru <quic_krichai@quicinc.com>,
        "Manivannan Sadhasivam" <mani@kernel.org>,
        "Masami Hiramatsu" <mhiramat@kernel.org>,
        <linux-kernel@vger.kernel.org>, <mhi@lists.linux.dev>,
        <linux-arm-msm@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>, <quic_vbadigan@quicinc.com>,
        <quic_ramkri@quicinc.com>, <quic_nitegupt@quicinc.com>,
        <quic_skananth@quicinc.com>, <quic_parass@quicinc.com>
Subject: Re: [PATCH v5] bus: mhi: host: Add tracing support
Message-ID: <20231201120648.795ea00c@gandalf.local.home>
In-Reply-To: <15c0130a-1a4b-c08b-714b-05166f48d23b@quicinc.com>
References: <20231127-ftrace_support-v5-1-eb67daead4f1@quicinc.com>
        <15c0130a-1a4b-c08b-714b-05166f48d23b@quicinc.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Dec 2023 10:01:33 -0700
Jeffrey Hugo <quic_jhugo@quicinc.com> wrote:

> > +DECLARE_EVENT_CLASS(mhi_process_event_ring,
> > +
> > +	TP_PROTO(const char *name, void *rp, __le64 ptr,
> > +		 __le32 dword0, __le32 dword1),
> > +
> > +	TP_ARGS(name, rp, ptr, dword0, dword1),
> > +
> > +	TP_STRUCT__entry(
> > +		__string(name, name)
> > +		__field(__le32, dword0)
> > +		__field(__le32, dword1)
> > +		__field(int, state)
> > +		__field(__le64, ptr)
> > +		__field(void *, rp)
> > +	),
> > +
> > +	TP_fast_assign(
> > +		__assign_str(name, name);
> > +		__entry->rp = rp;
> > +		__entry->ptr = ptr;
> > +		__entry->dword0 = dword0;
> > +		__entry->dword1 = dword1;
> > +		__entry->state = MHI_TRE_GET_EV_STATE((struct mhi_ring_element *)entry->rp);  
> 
> "entry"?
> Also, you have the "rp" that was passed into the trace, why not just 
> directly use that?

Agreed.

-- Steve
