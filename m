Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6116879F384
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 23:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232779AbjIMVMx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 17:12:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbjIMVMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 17:12:52 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FC381724
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 14:12:48 -0700 (PDT)
Received: from pps.filterd (m0134421.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38DKgJmM013648;
        Wed, 13 Sep 2023 21:11:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pps0720; bh=rQPMy7jLOgAQ49GKmRGuOnVicrkB/oJ8XOoSphPIGKc=;
 b=k9gSXpsl9bl/ehS45OWnPqmbdC+QPRtVJN/QOENM5lCyPYN+RiJfUWS5jdXI9uHCA8aZ
 ggXtNu53PBUgbXq+rlpqfabQRuLMCZ0QshQhAzeOd7JIGZAgaBr4/LHCaMizszznIx/9
 04CWWNA7J4PvkU7oSXH1HlHs9J5IAmC2M10Vnt3ypvJ4gcP789GjoW7hXftf6RSi7HC/
 vOMb9ap2DhOqV67H1NfcxtEEVciVk5VXcJD33IQJTca2w+Ed4iKLrr1pBy+XCR4mwE5d
 gqaq+YDXahfCPQBvFCg4u6KfB9QtfquWk22JRRDFhzIzLIpLTlMpepkjzzN+VUNfvMk7 lw== 
Received: from p1lg14881.it.hpe.com ([16.230.97.202])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3t3ey03cra-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Sep 2023 21:11:58 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14881.it.hpe.com (Postfix) with ESMTPS id E6913805E57;
        Wed, 13 Sep 2023 21:11:57 +0000 (UTC)
Received: from swahl-linux (unknown [16.231.227.39])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTPS id 7F77B8078EC;
        Wed, 13 Sep 2023 21:11:56 +0000 (UTC)
Date:   Wed, 13 Sep 2023 16:11:54 -0500
From:   Steve Wahl <steve.wahl@hpe.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Steve Wahl <steve.wahl@hpe.com>,
        Justin Ernst <justin.ernst@hpe.com>,
        Kyle Meyer <kyle.meyer@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Justin Stitt <justinstitt@google.com>
Subject: Re: [PATCH v2] x86/platform/uv: Rework NMI "action" modparam handling
Message-ID: <ZQIlmrO6KcfjXCbz@swahl-linux>
References: <20230913180111.85397-1-hdegoede@redhat.com>
 <ZQIka+OM1+2M3CsU@swahl-linux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZQIka+OM1+2M3CsU@swahl-linux>
X-Proofpoint-ORIG-GUID: WnwMJcY5iNMl67F4tHWG20COGTchuKSz
X-Proofpoint-GUID: WnwMJcY5iNMl67F4tHWG20COGTchuKSz
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-13_16,2023-09-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 suspectscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0
 clxscore=1015 malwarescore=0 mlxscore=0 mlxlogscore=999 impostorscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309130177
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 13, 2023 at 04:06:51PM -0500, Steve Wahl wrote:
> On Wed, Sep 13, 2023 at 08:01:11PM +0200, Hans de Goede wrote:
> > Rework NMI "action" modparam handling:
> > 
> > 1. Replace the uv_nmi_action string with an enum; and
> > 2. Use sysfs_match_string() for string parsing in param_set_action()
> > 
> > Suggested-by: Steve Wahl <steve.wahl@hpe.com>
> > Cc: Justin Stitt <justinstitt@google.com>
> > Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> > ---
> > Changes in v2:
> > - Also change uv_nmi_action to an enum to replace a bunch of
> >   strcmp() calls
> > ---
> >  arch/x86/platform/uv/uv_nmi.c | 104 +++++++++++++++++++---------------
> >  1 file changed, 57 insertions(+), 47 deletions(-)
> > 
> > diff --git a/arch/x86/platform/uv/uv_nmi.c b/arch/x86/platform/uv/uv_nmi.c
> > index 45d0c17ce77c..b92f1b4adeb0 100644
> > --- a/arch/x86/platform/uv/uv_nmi.c
> > +++ b/arch/x86/platform/uv/uv_nmi.c
> > @@ -178,49 +178,57 @@ module_param_named(debug, uv_nmi_debug, int, 0644);
> >  	} while (0)
> >  
> >  /* Valid NMI Actions */
> > -#define	ACTION_LEN	16
> > -static struct nmi_action {
> > -	char	*action;
> > -	char	*desc;
> > -} valid_acts[] = {
> > -	{	"kdump",	"do kernel crash dump"			},
> > -	{	"dump",		"dump process stack for each cpu"	},
> > -	{	"ips",		"dump Inst Ptr info for each cpu"	},
> > -	{	"kdb",		"enter KDB (needs kgdboc= assignment)"	},
> > -	{	"kgdb",		"enter KGDB (needs gdb target remote)"	},
> > -	{	"health",	"check if CPUs respond to NMI"		},
> > +enum action_t {
> > +	nmi_act_kdump,
> > +	nmi_act_dump,
> > +	nmi_act_ips,
> > +	nmi_act_kdb,
> > +	nmi_act_kgdb,
> > +	nmi_act_health,
> >  };
> > -typedef char action_t[ACTION_LEN];
> > -static action_t uv_nmi_action = { "dump" };
> > +
> > +static const char * const actions[] = {
> > +	[nmi_act_kdump] = "kdump",
> > +	[nmi_act_dump] = "dump",
> > +	[nmi_act_ips] = "ips",
> > +	[nmi_act_kdb] = "kdb",
> > +	[nmi_act_kgdb] = "kgdb",
> > +	[nmi_act_health] = "health",
> > +};
> > +
> > +static const char * const actions_desc[] = {
> > +	[nmi_act_kdump] = "do kernel crash dump",
> > +	[nmi_act_dump] = "dump process stack for each cpu",
> > +	[nmi_act_ips] = "dump Inst Ptr info for each cpu",
> > +	[nmi_act_kdb] = "enter KDB (needs kgdboc= assignment)",
> > +	[nmi_act_kgdb] = "enter KGDB (needs gdb target remote)",
> > +	[nmi_act_health] = "check if CPUs respond to NMI",
> > +};
> > +
> > +static_assert(ARRAY_SIZE(actions) == ARRAY_SIZE(actions_desc));
> > +
> > +static enum action_t uv_nmi_action = nmi_act_dump;
> >  
> >  static int param_get_action(char *buffer, const struct kernel_param *kp)
> >  {
> > -	return sprintf(buffer, "%s\n", uv_nmi_action);
> > +	return sprintf(buffer, "%s\n", actions[uv_nmi_action]);
> >  }
> >  
> >  static int param_set_action(const char *val, const struct kernel_param *kp)
> >  {
> > -	int i;
> > -	int n = ARRAY_SIZE(valid_acts);
> > -	char arg[ACTION_LEN];
> > +	int i, n = ARRAY_SIZE(actions);
> >  
> > -	/* (remove possible '\n') */
> > -	strscpy(arg, val, strnchrnul(val, sizeof(arg)-1, '\n') - val + 1);
> > -
> > -	for (i = 0; i < n; i++)
> > -		if (!strcmp(arg, valid_acts[i].action))
> > -			break;
> > -
> > -	if (i < n) {
> > -		strscpy(uv_nmi_action, arg, sizeof(uv_nmi_action));
> > -		pr_info("UV: New NMI action:%s\n", uv_nmi_action);
> > +	i = sysfs_match_string(actions, val);
> > +	if (i >= 0) {
> > +		uv_nmi_action = i;
> > +		pr_info("UV: New NMI action:%s\n", actions[i]);
> >  		return 0;
> >  	}
> >  
> > -	pr_err("UV: Invalid NMI action:%s, valid actions are:\n", arg);
> > +	pr_err("UV: Invalid NMI action:%s, valid actions are:\n", val);
> 
> This is a very minor nit in an otherwise fine patch:
> 
> Testing by echoing to /sys/module/uv_nmi/parameters/action shows an
> invalid action in val has a trailing newline that appears just before
> the comma:
> 
> # echo "invalid" >/sys/module/uv_nmi/parameters/action
> [ 1070.079303] UV: Invalid NMI action:invalid
> [ 1070.079303] , valid actions are:
> [ 1070.087485] UV: kdump    - do kernel crash dump
> [ 1070.092558] UV: dump     - dump process stack for each cpu
> [ 1070.098694] UV: ips      - dump Inst Ptr info for each cpu
> [ 1070.098697] UV: kdb      - enter KDB (needs kgdboc= assignment)
> [ 1070.098699] UV: kgdb     - enter KGDB (needs gdb target remote)
> [ 1070.098702] UV: health   - check if CPUs respond to NMI
> -bash: echo: write error: Invalid argument
> #
> 
> There's no newline in val if it comes from the kernel command line, so
> you can't just assume it's there.
> 
> It would be bad style to just overwrite the newline in place.
> Allocating space for and copying a string seems a waste.  Maybe rework
> the message so a possible newline doesn't look so awkward, by removing
> the comma?
> 
> > +	pr_err("UV: Invalid NMI action:%s Valid actions are:\n", val);
> 
> Frankly, I approve of this patch going in, regardless of what, if
> anything, is done about this.
> 
> Thanks.

I forgot to mention that testing included setting all option values from
kernel command line or /sys file, and sending NMIs to see that they
triggered the action that was set.

--> Steve

> Reveiwed-by: Steve Wahl <steve.wahl@hpe.com>
> Tested-by: Steve Wahl <steve.wahl@hpe.com>
> 
> 
> 
> >  	for (i = 0; i < n; i++)
> > -		pr_err("UV: %-8s - %s\n",
> > -			valid_acts[i].action, valid_acts[i].desc);
> > +		pr_err("UV: %-8s - %s\n", actions[i], actions_desc[i]);
> > +
> >  	return -EINVAL;
> >  }
> >  
> > @@ -228,15 +236,10 @@ static const struct kernel_param_ops param_ops_action = {
> >  	.get = param_get_action,
> >  	.set = param_set_action,
> >  };
> > -#define param_check_action(name, p) __param_check(name, p, action_t)
> > +#define param_check_action(name, p) __param_check(name, p, enum action_t)
> >  
> >  module_param_named(action, uv_nmi_action, action, 0644);
> >  
> > -static inline bool uv_nmi_action_is(const char *action)
> > -{
> > -	return (strncmp(uv_nmi_action, action, strlen(action)) == 0);
> > -}
> > -
> >  /* Setup which NMI support is present in system */
> >  static void uv_nmi_setup_mmrs(void)
> >  {
> > @@ -727,10 +730,10 @@ static void uv_nmi_dump_state_cpu(int cpu, struct pt_regs *regs)
> >  	if (cpu == 0)
> >  		uv_nmi_dump_cpu_ip_hdr();
> >  
> > -	if (current->pid != 0 || !uv_nmi_action_is("ips"))
> > +	if (current->pid != 0 || uv_nmi_action != nmi_act_ips)
> >  		uv_nmi_dump_cpu_ip(cpu, regs);
> >  
> > -	if (uv_nmi_action_is("dump")) {
> > +	if (uv_nmi_action == nmi_act_dump) {
> >  		pr_info("UV:%sNMI process trace for CPU %d\n", dots, cpu);
> >  		show_regs(regs);
> >  	}
> > @@ -798,7 +801,7 @@ static void uv_nmi_dump_state(int cpu, struct pt_regs *regs, int master)
> >  		int saved_console_loglevel = console_loglevel;
> >  
> >  		pr_alert("UV: tracing %s for %d CPUs from CPU %d\n",
> > -			uv_nmi_action_is("ips") ? "IPs" : "processes",
> > +			uv_nmi_action == nmi_act_ips ? "IPs" : "processes",
> >  			atomic_read(&uv_nmi_cpus_in_nmi), cpu);
> >  
> >  		console_loglevel = uv_nmi_loglevel;
> > @@ -874,7 +877,7 @@ static inline int uv_nmi_kdb_reason(void)
> >  static inline int uv_nmi_kdb_reason(void)
> >  {
> >  	/* Ensure user is expecting to attach gdb remote */
> > -	if (uv_nmi_action_is("kgdb"))
> > +	if (uv_nmi_action == nmi_act_kgdb)
> >  		return 0;
> >  
> >  	pr_err("UV: NMI error: KDB is not enabled in this kernel\n");
> > @@ -950,28 +953,35 @@ static int uv_handle_nmi(unsigned int reason, struct pt_regs *regs)
> >  	master = (atomic_read(&uv_nmi_cpu) == cpu);
> >  
> >  	/* If NMI action is "kdump", then attempt to do it */
> > -	if (uv_nmi_action_is("kdump")) {
> > +	if (uv_nmi_action == nmi_act_kdump) {
> >  		uv_nmi_kdump(cpu, master, regs);
> >  
> >  		/* Unexpected return, revert action to "dump" */
> >  		if (master)
> > -			strscpy(uv_nmi_action, "dump", sizeof(uv_nmi_action));
> > +			uv_nmi_action = nmi_act_dump;
> >  	}
> >  
> >  	/* Pause as all CPU's enter the NMI handler */
> >  	uv_nmi_wait(master);
> >  
> >  	/* Process actions other than "kdump": */
> > -	if (uv_nmi_action_is("health")) {
> > +	switch (uv_nmi_action) {
> > +	case nmi_act_health:
> >  		uv_nmi_action_health(cpu, regs, master);
> > -	} else if (uv_nmi_action_is("ips") || uv_nmi_action_is("dump")) {
> > +		break;
> > +	case nmi_act_ips:
> > +	case nmi_act_dump:
> >  		uv_nmi_dump_state(cpu, regs, master);
> > -	} else if (uv_nmi_action_is("kdb") || uv_nmi_action_is("kgdb")) {
> > +		break;
> > +	case nmi_act_kdb:
> > +	case nmi_act_kgdb:
> >  		uv_call_kgdb_kdb(cpu, regs, master);
> > -	} else {
> > +		break;
> > +	default:
> >  		if (master)
> > -			pr_alert("UV: unknown NMI action: %s\n", uv_nmi_action);
> > +			pr_alert("UV: unknown NMI action: %d\n", uv_nmi_action);
> >  		uv_nmi_sync_exit(master);
> > +		break;
> >  	}
> >  
> >  	/* Clear per_cpu "in_nmi" flag */
> > -- 
> > 2.41.0
> > 
> 
> -- 
> Steve Wahl, Hewlett Packard Enterprise

-- 
Steve Wahl, Hewlett Packard Enterprise
