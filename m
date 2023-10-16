Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D62A7CAD11
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 17:12:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233464AbjJPPMb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 11:12:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233615AbjJPPM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 11:12:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1B2BE1;
        Mon, 16 Oct 2023 08:12:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16235C433CD;
        Mon, 16 Oct 2023 15:12:23 +0000 (UTC)
Date:   Mon, 16 Oct 2023 11:13:57 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Krishna chaitanya chundru <quic_krichai@quicinc.com>
Cc:     Manivannan Sadhasivam <mani@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        <linux-kernel@vger.kernel.org>, <mhi@lists.linux.dev>,
        <linux-arm-msm@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>, <quic_vbadigan@quicinc.com>,
        <quic_ramkri@quicinc.com>, <quic_nitegupt@quicinc.com>,
        <quic_skananth@quicinc.com>, <quic_parass@quicinc.com>
Subject: Re: [PATCH v2] bus: mhi: host: Add tracing support
Message-ID: <20231016111357.74b991d4@gandalf.local.home>
In-Reply-To: <20231013-ftrace_support-v2-1-6e893ce010b5@quicinc.com>
References: <20231013-ftrace_support-v2-1-6e893ce010b5@quicinc.com>
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

On Fri, 13 Oct 2023 15:22:19 +0530
Krishna chaitanya chundru <quic_krichai@quicinc.com> wrote:

> +++ b/include/trace/events/mhi_host.h
> @@ -0,0 +1,287 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#undef TRACE_SYSTEM
> +#define TRACE_SYSTEM mhi_host
> +
> +#if !defined(_TRACE_EVENT_MHI_HOST_H) || defined(TRACE_HEADER_MULTI_READ)
> +#define _TRACE_EVENT_MHI_HOST_H
> +
> +#include <linux/tracepoint.h>
> +#define MHI_STATE						\
> +	EM(MHI_STATE_RESET,	"RESET")			\
> +	EM(MHI_STATE_READY,	"READY")			\
> +	EM(MHI_STATE_M0,	"M0")				\
> +	EM(MHI_STATE_M1,	"M1")				\
> +	EM(MHI_STATE_M2,	"M2")				\
> +	EM(MHI_STATE_M3,	"M3")				\
> +	EM(MHI_STATE_M3_FAST,	"M3 FAST")			\
> +	EM(MHI_STATE_BHI,	"BHI")				\
> +	EMe(MHI_STATE_SYS_ERR,	"SYS ERROR")
> +
> +#define MHI_EE							\
> +	EM(MHI_EE_PBL,		"PRIMARY BOOTLOADER")		\
> +	EM(MHI_EE_SBL,		"SECONDARY BOOTLOADER")		\
> +	EM(MHI_EE_AMSS,		"MISSION MODE")			\
> +	EM(MHI_EE_RDDM,		"RAMDUMP DOWNLOAD MODE")	\
> +	EM(MHI_EE_WFW,		"WLAN FIRMWARE")		\
> +	EM(MHI_EE_PTHRU,	"PASS THROUGH")			\
> +	EM(MHI_EE_EDL,		"EMERGENCY DOWNLOAD")		\
> +	EM(MHI_EE_FP,		"FLASH PROGRAMMER")		\
> +	EM(MHI_EE_DISABLE_TRANSITION,	"DISABLE")		\
> +	EMe(MHI_EE_NOT_SUPPORTED,	"NOT SUPPORTED")
> +
> +#define MHI_PM_STATE							\
> +	EM(MHI_PM_STATE_DISABLE,	"DISABLE")			\
> +	EM(MHI_PM_STATE_POR,		"POWER ON RESET")		\
> +	EM(MHI_PM_STATE_M0,		"M0")				\
> +	EM(MHI_PM_STATE_M2,		"M2")				\
> +	EM(MHI_PM_STATE_M3_ENTER,	"M?->M3")			\
> +	EM(MHI_PM_STATE_M3,		"M3")				\
> +	EM(MHI_PM_STATE_M3_EXIT,	"M3->M0")			\
> +	EM(MHI_PM_STATE_FW_DL_ERR,	"Firmware Download Error")	\
> +	EM(MHI_PM_STATE_SYS_ERR_DETECT,		"SYS ERROR Detect")	\
> +	EM(MHI_PM_STATE_SYS_ERR_PROCESS,	"SYS ERROR Process")	\
> +	EM(MHI_PM_STATE_SHUTDOWN_PROCESS,	"SHUTDOWN Process")	\
> +	EMe(MHI_PM_STATE_LD_ERR_FATAL_DETECT,	"Linkdown or Error Fatal Detect")
> +
> +#define MHI_CH_STATE						\
> +	EM(MHI_CH_STATE_TYPE_RESET, "RESET")			\
> +	EM(MHI_CH_STATE_TYPE_STOP, "STOP")			\
> +	EMe(MHI_CH_STATE_TYPE_START, "START")
> +
> +#define MHI_DEV_ST_TRANSITION						\
> +	EM(DEV_ST_TRANSITION_PBL,	"PBL")				\
> +	EM(DEV_ST_TRANSITION_READY,	"READY")			\
> +	EM(DEV_ST_TRANSITION_SBL,	"SBL")				\
> +	EM(DEV_ST_TRANSITION_MISSION_MODE,	"MISSION MODE")		\
> +	EM(DEV_ST_TRANSITION_FP,		"FLASH PROGRAMMER")	\
> +	EM(DEV_ST_TRANSITION_SYS_ERR,		"SYS ERROR")		\
> +	EMe(DEV_ST_TRANSITION_DISABLE,		"DISABLE")
> +
> +/* Enums require being exported to userspace, for user tool parsing */
> +#undef	EM
> +#undef	EMe
> +#define	EM(a, b)	TRACE_DEFINE_ENUM(a);
> +#define	EMe(a, b)	TRACE_DEFINE_ENUM(a);
> +
> +MHI_STATE
> +MHI_EE
> +MHI_PM_STATE
> +MHI_CH_STATE
> +MHI_DEV_ST_TRANSITION
> +
> +/*
> + * Now redefine the EM() and EMe() macros to map the enums to the strings
> + * that will be printed in the output.
> + */
> +#undef EM
> +#undef EMe
> +#define EM(a, b)	{a, b},
> +#define EMe(a, b)	{a, b}
> +
> +TRACE_EVENT(mhi_gen_tre,
> +
> +	TP_PROTO(const char *name, int ch_num, u64 wp, __le64 tre_ptr,
> +		 __le32 dword0, __le32 dword1),
> +
> +	TP_ARGS(name, ch_num, wp, tre_ptr, dword0, dword1),
> +
> +	TP_STRUCT__entry(
> +		__string(name, name)
> +		__field(int, ch_num)

This is fine as __string() is four bytes in the event (2 bytes for offset
where the string exists, and 2 bytes for its length).

> +		__field(u64, wp)
> +		__field(__le64, tre_ptr)

Which makes the two 8 byte fields aligned. Good!

> +		__field(__le32, dword0)
> +		__field(__le32, dword1)
> +	),
> +
> +	TP_fast_assign(
> +		__assign_str(name, name);
> +		__entry->ch_num = ch_num;
> +		__entry->wp = wp;
> +		__entry->tre_ptr = tre_ptr;
> +		__entry->dword0 = dword0;
> +		__entry->dword1 = dword1;
> +	),
> +
> +	TP_printk("%s: Chan: %d WP: 0x%llx TRE: 0x%llx 0x%08x 0x%08x\n",
> +		  __get_str(name), __entry->ch_num, __entry->wp, __entry->tre_ptr,
> +		  __entry->dword0, __entry->dword1)
> +);
> +
> +TRACE_EVENT(mhi_intvec_threaded_handler,
> +
> +	TP_PROTO(const char *name, int local_ee, int state, int dev_ee, int dev_state),
> +
> +	TP_ARGS(name, local_ee, state, dev_ee, dev_state),
> +
> +	TP_STRUCT__entry(
> +		__string(name, name)
> +		__field(int, local_ee)
> +		__field(int, state)
> +		__field(int, dev_ee)
> +		__field(int, dev_state)
> +	),
> +
> +	TP_fast_assign(
> +		__assign_str(name, name);
> +		__entry->local_ee = local_ee;
> +		__entry->state = state;
> +		__entry->dev_ee = dev_ee;
> +		__entry->dev_state = dev_state;
> +	),
> +
> +	TP_printk("%s: local ee: %s state: %s device ee: %s state: %s\n",
> +		  __get_str(name),
> +		  __print_symbolic(__entry->local_ee, MHI_EE),
> +		  __print_symbolic(__entry->state, MHI_STATE),
> +		  __print_symbolic(__entry->dev_ee, MHI_EE),
> +		  __print_symbolic(__entry->dev_state, MHI_STATE))
> +);
> +
> +TRACE_EVENT(mhi_tryset_pm_state,
> +
> +	TP_PROTO(const char *name, int pm_state),
> +
> +	TP_ARGS(name, pm_state),
> +
> +	TP_STRUCT__entry(
> +		__string(name, name)
> +		__field(int, pm_state)
> +	),
> +
> +	TP_fast_assign(
> +		__assign_str(name, name);
> +		if (pm_state)
> +			pm_state = __fls(pm_state);
> +		__entry->pm_state = pm_state;
> +	),
> +
> +	TP_printk("%s: PM state: %s\n", __get_str(name),
> +		  __print_symbolic(__entry->pm_state, MHI_PM_STATE))
> +);
> +
> +TRACE_EVENT(mhi_process_data_event_ring,
> +
> +	TP_PROTO(const char *name, __le64 ptr, __le32 dword0, __le32 dword1),
> +
> +	TP_ARGS(name, ptr, dword0, dword1),
> +
> +	TP_STRUCT__entry(
> +		__string(name, name)
> +		__field(__le64, ptr)

Here, I would switch the __field(__le64, ptr) with the __string().

		__field(__le64, ptr)
		__string(name, name)

otherwise you just created a 4 byte hole in the ring buffer, wasting
precious ring buffer space.

> +		__field(__le32, dword0)
> +		__field(__le32, dword1)
> +	),
> +
> +	TP_fast_assign(
> +		__assign_str(name, name);
> +		__entry->ptr = ptr;
> +		__entry->dword0 = dword0;
> +		__entry->dword1 = dword1;
> +	),
> +
> +	TP_printk("%s: Processing Event:0x%llx 0x%08x 0x%08x\n",
> +		  __get_str(name), __entry->ptr, __entry->dword0, __entry->dword1)
> +);
> +
> +TRACE_EVENT(mhi_process_ctrl_ev_ring,
> +
> +	TP_PROTO(const char *name, u64 rp, __le64 ptr, __le32 dword0, __le32 dword1, int state),
> +
> +	TP_ARGS(name, rp, ptr, dword0, dword1, state),
> +
> +	TP_STRUCT__entry(
> +		__string(name, name)
> +		__field(u64, rp)
> +		__field(__le64, ptr)

I would move __string(name, name) here (after the two 8 byte fields).

-- Steve

> +		__field(__le32, dword0)
> +		__field(__le32, dword1)
> +		__field(int, state)
> +	),
> +
> +	TP_fast_assign(
> +		__assign_str(name, name);
> +		__entry->rp = rp;
> +		__entry->ptr = ptr;
> +		__entry->dword0 = dword0;
> +		__entry->dword1 = dword1;
> +		__entry->state = state;
> +	),
> +
> +	TP_printk("%s: RP:0x%llx Processing Event:0x%llx 0x%08x 0x%08x state:%s\n",
> +		  __get_str(name), __entry->rp, __entry->ptr, __entry->dword0,
> +		  __entry->dword1, __print_symbolic(__entry->state, MHI_STATE))
> +);
> +
> +TRACE_EVENT(mhi_update_channel_state_start,
> +
> +	TP_PROTO(const char *name, int ch_num, int state),
> +
> +	TP_ARGS(name, ch_num, state),
> +
> +	TP_STRUCT__entry(
> +		__string(name, name)
> +		__field(int, ch_num)
> +		__field(int, state)
> +	),
> +
> +	TP_fast_assign(
> +		__assign_str(name, name);
> +		__entry->ch_num = ch_num;
> +		__entry->state = state;
> +	),
> +
> +	TP_printk("%s: ch%d: Updating state to: %s\n",
> +		  __get_str(name), __entry->ch_num,
> +		  __print_symbolic(__entry->state, MHI_CH_STATE))
> +);
> +
> +TRACE_EVENT(mhi_update_channel_state_end,
> +
> +	TP_PROTO(const char *name, int ch_num, int state),
> +
> +	TP_ARGS(name, ch_num, state),
> +
> +	TP_STRUCT__entry(
> +		__string(name, name)
> +		__field(int, ch_num)
> +		__field(int, state)
> +	),
> +
> +	TP_fast_assign(
> +		__assign_str(name, name);
> +		__entry->ch_num = ch_num;
> +		__entry->state = state;
> +	),
> +
> +	TP_printk("%s: ch%d: Updated state to: %s\n",
> +		  __get_str(name), __entry->ch_num,
> +		  __print_symbolic(__entry->state, MHI_CH_STATE))
> +);
> +
> +TRACE_EVENT(mhi_pm_st_transition,
> +
> +	TP_PROTO(const char *name, int state),
> +
> +	TP_ARGS(name, state),
> +
> +	TP_STRUCT__entry(
> +		__string(name, name)
> +		__field(int, state)
> +	),
> +
> +	TP_fast_assign(
> +		__assign_str(name, name);
> +		__entry->state = state;
> +	),
> +
> +	TP_printk("%s: Handling state transition: %s\n", __get_str(name),
> +		  __print_symbolic(__entry->state, MHI_DEV_ST_TRANSITION))
> +);
> +
> +#endif
> +#include <trace/define_trace.h>

