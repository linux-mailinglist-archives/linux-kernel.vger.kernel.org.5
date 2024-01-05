Return-Path: <linux-kernel+bounces-18427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 54309825D48
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 00:58:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEB171F22CBC
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 23:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EC58364A3;
	Fri,  5 Jan 2024 23:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="jLu+C3WG"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-00190b01.pphosted.com (mx0a-00190b01.pphosted.com [67.231.149.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF63B360B9
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 23:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=akamai.com
Received: from pps.filterd (m0122333.ppops.net [127.0.0.1])
	by mx0a-00190b01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 405MSlT8024355;
	Fri, 5 Jan 2024 22:46:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	jan2016.eng; bh=E4HinPTkCDFa4QOXQVhGBq5dpkVyw5V778fGHtU+jV0=; b=
	jLu+C3WGqgJaWO/EBM/U3Cdfeuat/1y3TTUCp/ItG/P6LqyqgE2yjZk1VWTE1RlF
	x8dsTWS5S+KxDah+RFiZui6bmXJXyxMd/pRs7WxZrWAo35YuX6khEYTMkQzzXlON
	b4yK/oJ7wItEoA/q00wxQwVFb3Sjv1gQcK3/FDh2B0LiKZtdFKWIgW+CE+6EWB3c
	txWIR6TiXXiZhM6ImNiRkCcqrmUtueFi9xJU9Yxn4oC7OekMcuD5oiBgRm+UDaEm
	QgciGna+VpxqJE+B6t6aa3IceC9etajGjCEYdZJg+JnDvxXiCK/mT9/s4a1sBL5H
	g1NLPuVPyKv4MWnX28Y1jw==
Received: from prod-mail-ppoint1 (prod-mail-ppoint1.akamai.com [184.51.33.18] (may be forged))
	by mx0a-00190b01.pphosted.com (PPS) with ESMTPS id 3vetkps4rb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Jan 2024 22:46:52 +0000 (GMT)
Received: from pps.filterd (prod-mail-ppoint1.akamai.com [127.0.0.1])
	by prod-mail-ppoint1.akamai.com (8.17.1.19/8.17.1.19) with ESMTP id 405LJR2J016806;
	Fri, 5 Jan 2024 17:46:42 -0500
Received: from prod-mail-relay10.akamai.com ([172.27.118.251])
	by prod-mail-ppoint1.akamai.com (PPS) with ESMTP id 3ve163yjvv-1;
	Fri, 05 Jan 2024 17:46:42 -0500
Received: from [172.19.39.209] (bos-lpa4700a.bos01.corp.akamai.com [172.19.39.209])
	by prod-mail-relay10.akamai.com (Postfix) with ESMTP id B2CFD6410D;
	Fri,  5 Jan 2024 22:46:41 +0000 (GMT)
Message-ID: <69bd53de-0948-469f-ae58-48098af1973c@akamai.com>
Date: Fri, 5 Jan 2024 17:46:41 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/15] dyndbg: add open and close commands for trace
Content-Language: en-US
To: =?UTF-8?Q?=C5=81ukasz_Bartosik?= <lb@semihalf.com>,
        Jim Cromie <jim.cromie@gmail.com>,
        Andrew Morton
 <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Douglas Anderson <dianders@chromium.org>
Cc: Guenter Roeck <groeck@google.com>, Yaniv Tzoreff <yanivt@google.com>,
        Benson Leung <bleung@google.com>, Steven Rostedt <rostedt@goodmis.org>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Pekka Paalanen <ppaalanen@gmail.com>,
        Sean Paul <seanpaul@chromium.org>, Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org, upstream@semihalf.com
References: <20231130234048.157509-1-lb@semihalf.com>
 <20231130234048.157509-11-lb@semihalf.com>
From: Jason Baron <jbaron@akamai.com>
In-Reply-To: <20231130234048.157509-11-lb@semihalf.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-05_08,2024-01-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999 bulkscore=0
 mlxscore=0 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401050174
X-Proofpoint-ORIG-GUID: SLpskQQ9Md09-qCxLEgnluiXmLnUzKB7
X-Proofpoint-GUID: SLpskQQ9Md09-qCxLEgnluiXmLnUzKB7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-05_08,2024-01-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 impostorscore=0
 bulkscore=0 clxscore=1011 adultscore=0 suspectscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401050175

On 11/30/23 6:40 PM, Łukasz Bartosik wrote:
> Add open and close commands for opening and closing trace instances.
> The open command has to be mandatory followed by a trace instance name.
> If a trace instance already exists in <debugfs>/tracing/instances
> directory then the open command will reuse it otherwise a new trace
> instance with a name provided to the open will be created. Close
> command closes previously opened trace instance. The close will
> fail if a user tries to close non-existent trace instances or an
> instance which was not previously opened.
> 
> For example the following command will open (create or reuse existing)
> trace instance located in <debugfs>/tracing/instances/usbcore:
> 
>      echo "open usbcore" > <debugfs>/dynamic_debug/control

Hi,

I'm wondering why this needs to be part of dynamic debug? Can't we make 
trace instances via 'mkdir' and then use those from the dynamic debug side?

Thanks,

-Jason




> 
> Signed-off-by: Łukasz Bartosik <lb@semihalf.com>
> ---
>   lib/Kconfig.debug   |   1 +
>   lib/dynamic_debug.c | 193 ++++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 194 insertions(+)
> 
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 5bc56c7247a2..f184c3c91ba3 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -181,6 +181,7 @@ config DYNAMIC_DEBUG_CORE
>   	bool "Enable core function of dynamic debug support"
>   	depends on PRINTK
>   	depends on (DEBUG_FS || PROC_FS)
> +	depends on TRACING
>   	help
>   	  Enable core functional support of dynamic debug. It is useful
>   	  when you want to tie dynamic debug to your kernel modules with
> diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
> index 0dc9ec76b867..43e94023a4eb 100644
> --- a/lib/dynamic_debug.c
> +++ b/lib/dynamic_debug.c
> @@ -36,6 +36,7 @@
>   #include <linux/sched.h>
>   #include <linux/device.h>
>   #include <linux/netdevice.h>
> +#include <linux/trace.h>
>   
>   #define CREATE_TRACE_POINTS
>   #include <trace/events/dyndbg.h>
> @@ -73,6 +74,25 @@ struct flag_settings {
>   	unsigned int mask;
>   };
>   
> +#define DD_OPEN_CMD	"open"
> +#define DD_CLOSE_CMD	"close"
> +#define DD_TR_EVENT	"0"
> +
> +struct ddebug_trace_inst {
> +	const char *name;
> +	struct trace_array *arr;
> +};
> +
> +/*
> + * TRACE_DST_MAX value is reserved for writing
> + * debug logs to trace events (prdbg, devdbg)
> + */
> +struct ddebug_trace {
> +	struct ddebug_trace_inst inst[TRACE_DST_MAX-1];
> +	DECLARE_BITMAP(bmap, TRACE_DST_MAX-1);
> +	int bmap_size;
> +};
> +
>   static DEFINE_MUTEX(ddebug_lock);
>   static LIST_HEAD(ddebug_tables);
>   static int verbose;
> @@ -80,6 +100,8 @@ module_param(verbose, int, 0644);
>   MODULE_PARM_DESC(verbose, " dynamic_debug/control processing "
>   		 "( 0 = off (default), 1 = module add/rm, 2 = >control summary, 3 = parsing, 4 = per-site changes)");
>   
> +static struct ddebug_trace tr = { .bmap_size = TRACE_DST_MAX-1 };
> +
>   static inline struct dd_ctrl *get_ctrl(struct _ddebug *desc)
>   {
>   	return &desc->ctrl;
> @@ -171,6 +193,148 @@ static void vpr_info_dq(const struct ddebug_query *query, const char *msg)
>   		  query->first_lineno, query->last_lineno, query->class_string);
>   }
>   
> +static bool is_ddebug_cmd(const char *str)
> +{
> +	if (!strcmp(str, DD_OPEN_CMD) ||
> +	    !strcmp(str, DD_CLOSE_CMD))
> +		return true;
> +
> +	return false;
> +}
> +
> +static bool validate_tr_name(const char *str)
> +{
> +	/* "0" is reserved for writing debug logs to trace events (prdbg, devdbg) */
> +	if (!strcmp(str, DD_TR_EVENT))
> +		return false;
> +
> +	/* we allow trace instance names to include ^\w+ and underscore */
> +	while (*str != '\0') {
> +		if (!isalnum(*str) && *str != '_')
> +			return false;
> +		str++;
> +	}
> +
> +	return true;
> +}
> +
> +static int find_tr_instance(const char *name)
> +{
> +	int idx;
> +
> +	for_each_set_bit(idx, tr.bmap, tr.bmap_size)
> +		if (!strcmp(tr.inst[idx].name, name))
> +			return idx;
> +
> +	return -ENOENT;
> +}
> +
> +static int handle_tr_opend_cmd(const char *arg)
> +{
> +	struct ddebug_trace_inst *inst;
> +	int idx, ret = 0;
> +
> +	mutex_lock(&ddebug_lock);
> +
> +	idx = find_first_zero_bit(tr.bmap, tr.bmap_size);
> +	if (idx == tr.bmap_size) {
> +		ret = -ENOSPC;
> +		goto end;
> +	}
> +
> +	if (!validate_tr_name(arg)) {
> +		pr_err("invalid instance name:%s\n", arg);
> +		ret = -EINVAL;
> +		goto end;
> +	}
> +
> +	if (find_tr_instance(arg) >= 0) {
> +		pr_err("instance is already opened name:%s\n ", arg);
> +		ret = -EEXIST;
> +		goto end;
> +	}
> +
> +	inst = &tr.inst[idx];
> +	inst->name = kstrdup(arg, GFP_KERNEL);
> +	if (!inst->name) {
> +		ret = -ENOMEM;
> +		goto end;
> +	}
> +
> +	inst->arr = trace_array_get_by_name(inst->name);
> +	if (!inst->arr) {
> +		ret = -EINVAL;
> +		goto end;
> +	}
> +
> +	ret = trace_array_init_printk(inst->arr);
> +	if (ret) {
> +		trace_array_put(inst->arr);
> +		trace_array_destroy(inst->arr);
> +		goto end;
> +	}
> +
> +	set_bit(idx, tr.bmap);
> +	v3pr_info("opened trace instance idx=%d, name=%s\n", idx, arg);
> +end:
> +	mutex_unlock(&ddebug_lock);
> +	return ret;
> +}
> +
> +static int handle_tr_close_cmd(const char *arg)
> +{
> +	struct ddebug_trace_inst *inst;
> +	int idx, ret = 0;
> +
> +	mutex_lock(&ddebug_lock);
> +
> +	idx = find_tr_instance(arg);
> +	if (idx < 0) {
> +		ret = idx;
> +		goto end;
> +	}
> +
> +	inst = &tr.inst[idx];
> +
> +	trace_array_put(inst->arr);
> +	/*
> +	 * don't destroy trace instance but let user do it manually
> +	 * with rmdir command at a convenient time later, if it is
> +	 * destroyed here all debug logs will be lost
> +	 *
> +	 * trace_array_destroy(inst->arr);
> +	 */
> +	inst->arr = NULL;
> +
> +	kfree(inst->name);
> +	inst->name = NULL;
> +
> +	clear_bit(idx, tr.bmap);
> +	v3pr_info("closed trace instance idx=%d, name=%s\n", idx, arg);
> +end:
> +	mutex_unlock(&ddebug_lock);
> +	return ret;
> +}
> +
> +static int ddebug_parse_cmd(char *words[], int nwords)
> +{
> +	int ret;
> +
> +	if (nwords != 1)
> +		return -EINVAL;
> +
> +	if (!strcmp(words[0], DD_OPEN_CMD))
> +		ret = handle_tr_opend_cmd(words[1]);
> +	else if (!strcmp(words[0], DD_CLOSE_CMD))
> +		ret = handle_tr_close_cmd(words[1]);
> +	else {
> +		pr_err("invalid command %s\n", words[0]);
> +		ret = -EINVAL;
> +	}
> +
> +	return ret;
> +}
> +
>   static struct ddebug_class_map *ddebug_find_valid_class(struct ddebug_table const *dt,
>   							  const char *class_string, int *class_id)
>   {
> @@ -567,6 +731,11 @@ static int ddebug_exec_query(char *query_string, const char *modname)
>   		pr_err("tokenize failed\n");
>   		return -EINVAL;
>   	}
> +
> +	/* check for open, close commands */
> +	if (is_ddebug_cmd(words[0]))
> +		return ddebug_parse_cmd(words, nwords-1);
> +
>   	/* check flags 1st (last arg) so query is pairs of spec,val */
>   	if (ddebug_parse_flags(words[nwords-1], &modifiers)) {
>   		pr_err("flags parse failed\n");
> @@ -1191,6 +1360,20 @@ static struct _ddebug *ddebug_iter_next(struct ddebug_iter *iter)
>   	return &iter->table->ddebugs[iter->idx];
>   }
>   
> +/*
> + * Check if the iterator points to the last _ddebug object
> + * to traverse.
> + */
> +static bool ddebug_iter_is_last(struct ddebug_iter *iter)
> +{
> +	if (iter->table == NULL)
> +		return false;
> +	if (iter->idx-1 < 0 &&
> +	    list_is_last(&iter->table->link, &ddebug_tables))
> +		return true;
> +	return false;
> +}
> +
>   /*
>    * Seq_ops start method.  Called at the start of every
>    * read() call from userspace.  Takes the ddebug_lock and
> @@ -1281,6 +1464,16 @@ static int ddebug_proc_show(struct seq_file *m, void *p)
>   	}
>   	seq_puts(m, "\n");
>   
> +	if (ddebug_iter_is_last(iter) &&
> +	    !bitmap_empty(tr.bmap, tr.bmap_size)) {
> +		int idx;
> +
> +		seq_puts(m, "\n");
> +		seq_puts(m, "Opened trace instances:\n");
> +		for_each_set_bit(idx, tr.bmap, tr.bmap_size)
> +			seq_printf(m, "%s\n", tr.inst[idx].name);
> +	}
> +
>   	return 0;
>   }
>   

