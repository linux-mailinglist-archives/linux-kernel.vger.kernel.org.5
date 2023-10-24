Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92A627D5845
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 18:29:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234576AbjJXQ3M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 12:29:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343861AbjJXQ3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 12:29:01 -0400
X-Greylist: delayed 237 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 24 Oct 2023 09:28:56 PDT
Received: from mx0a-00190b01.pphosted.com (mx0a-00190b01.pphosted.com [IPv6:2620:100:9001:583::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A6B6AC
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 09:28:56 -0700 (PDT)
Received: from pps.filterd (m0122332.ppops.net [127.0.0.1])
        by mx0a-00190b01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 39OEb5m3005187;
        Tue, 24 Oct 2023 17:24:54 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=
        message-id:date:mime-version:subject:to:cc:references:from
        :in-reply-to:content-type:content-transfer-encoding; s=
        jan2016.eng; bh=X0j9myhijs+hId7Y31hsWCj0B92crioKt/Uefi0G8tg=; b=
        nAgHyV04N/C81HqaxJuXSbYI9/l57+sHEzWO3nVQk9lNoWZYSL5V0Hp62149/C10
        sZ9VG5Fs56N08KMGuqKoGHrMp+/dL2h/cLWdBl6cjbwkbqobVMe1o3j6UJyys2sp
        bunAVFRhtAv3Xk7GTzA00UdCPrvzh9usg7qwCv0GTFdM9RDqDlyZRjirEUVIYAkA
        0ZQWnFi7zXrl6VFkZLyw3MrFLJSxUiVk50KqX7V7NJxu+PYAPQlxFCSpYUv1kTtQ
        /MLDsujkL4ohoi3ZaeKzRHBwU2WwNmaT/SeohN2p5CyISipEgsq7DPh0EY5QgZLc
        l3vP0E0NiDE/9aeYFVKSfg==
Received: from prod-mail-ppoint1 (prod-mail-ppoint1.akamai.com [184.51.33.18] (may be forged))
        by mx0a-00190b01.pphosted.com (PPS) with ESMTPS id 3tv6q2sn9f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Oct 2023 17:24:54 +0100 (BST)
Received: from pps.filterd (prod-mail-ppoint1.akamai.com [127.0.0.1])
        by prod-mail-ppoint1.akamai.com (8.17.1.19/8.17.1.19) with ESMTP id 39OEH5H3023434;
        Tue, 24 Oct 2023 12:24:52 -0400
Received: from prod-mail-relay11.akamai.com ([172.27.118.250])
        by prod-mail-ppoint1.akamai.com (PPS) with ESMTP id 3tv9yx5wnr-1;
        Tue, 24 Oct 2023 12:24:52 -0400
Received: from [172.19.37.178] (bos-lpa4700a.bos01.corp.akamai.com [172.19.37.178])
        by prod-mail-relay11.akamai.com (Postfix) with ESMTP id BBA8631A6A;
        Tue, 24 Oct 2023 16:24:51 +0000 (GMT)
Message-ID: <b76cc0b1-4a90-5d03-9e38-ac06ef5fd4f8@akamai.com>
Date:   Tue, 24 Oct 2023 12:24:51 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v1] dynamic_debug: add support for logs destination
To:     =?UTF-8?Q?=c5=81ukasz_Bartosik?= <lb@semihalf.com>,
        Jim Cromie <jim.cromie@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Douglas Anderson <dianders@chromium.org>
Cc:     Guenter Roeck <groeck@google.com>,
        Yaniv Tzoreff <yanivt@google.com>,
        Benson Leung <bleung@google.com>, linux-kernel@vger.kernel.org,
        upstream@semihalf.com
References: <20230915154856.1896062-1-lb@semihalf.com>
Content-Language: en-US
From:   Jason Baron <jbaron@akamai.com>
In-Reply-To: <20230915154856.1896062-1-lb@semihalf.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-24_16,2023-10-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 malwarescore=0
 mlxlogscore=999 spamscore=0 phishscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310170001
 definitions=main-2310240141
X-Proofpoint-GUID: 83QP_WyxG282yVzI-_sHzW2vpgZ81Omu
X-Proofpoint-ORIG-GUID: 83QP_WyxG282yVzI-_sHzW2vpgZ81Omu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-24_16,2023-10-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 clxscore=1011
 mlxlogscore=999 priorityscore=1501 lowpriorityscore=0 adultscore=0
 malwarescore=0 phishscore=0 bulkscore=0 mlxscore=0 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2310170000 definitions=main-2310240142
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/15/23 11:48 AM, Łukasz Bartosik wrote:
> Add support for selection of dynamic debug logs destination.
> When enabled it allows to configure destination of each callsite
> individually. The option adds a framework (described by struct
> ddebug_dst_ops) which provides flexible means to add a new destination
> for debug logs. On top of the framework support for trace instance as
> destination is added. By default destination of debug logs is syslog.
> Syslog can be set explicitly by using dst keyword or is selected by
> default when dst keyword is omitted, for example:
> 
> localhost ~ # echo -n "module usbcore dst syslog =p" >
> 			    <debugfs>/dynamic_debug/control
> or
> 
> localhost ~ # echo -n "module usbcore =p" >
> 			    <debugfs>/dynamic_debug/control
> 
> To enable a trace instance as a destination of debug logs a user
> can for example issue the command:
> 
> localhost ~ # echo -n "module usbcore dst trace:usb =p" >
> 			    <debugfs>/dynamic_debug/control


Sorry for the late reply here. So I normally thing of the dynamic debug 
keywords- func,file,line,etc... as 'selectors'. Like these control which 
sites are selected. Whereas the 'dst' keyword is where the output of 
what is selected goes to. So it feels like it should be more like something:

echo "module usbcore =T:usb" > <debugfs>/dyanmic_debug/control

And then if there are other flags maybe we need a comma?

echo "module usbcore =T:usb,ptm" > <debugfs>/dyanmic_debug/control

or

echo "module usbcore =ptmT:usb" > <debugfs>/dyanmic_debug/control

And if you just have 'T' like:

echo "module usbcore =ptmT" > <debugfs>/dyanmic_debug/control

That means use the 'default' trace buffer. And 'p' continues to mean the 
printk buffer. So you could send lines to both. But you can't send 
output to more than one trace buffer (although we could relax that in 
the future, if needed with another ':' separator?).

Thanks,

-Jason

> 
> The command will write debug logs from usbcore subsystem to the
> trace instance named "usb" and the captured logs can be read
> later with the command:
> 
> localhost ~ # cat <debugfs>/tracing/instances/usb/trace
> 
> When trace instance name is omitted the debug logs will be written
> to "ddebug_default" trace instance:
> 
> localhost ~ # cat <debugfs>/tracing/instances/ddebug_default/trace
> 
> The DYNAMIC_DEBUG_DST option adds destination information
> in the dynamic debug control:
> 
> localhost ~ # cat  <debugfs>/dynamic_debug/control
> drivers/usb/core/usb-acpi.c:143 [usbcore]usb_acpi_set_power_state =p "acpi: power failed to be set\n" trace:usb
> drivers/usb/core/usb-acpi.c:141 [usbcore]usb_acpi_set_power_state =p "acpi: power was set to %d\n" trace:usb
> 
> There are two modes of operation for dynamic debug logs destination
> which can be selected during configuration stage of a kernel:
> 
> * Dynamic - callsites configuration and destination of debug logs
> can be dynamically changed during runtime. This has slight impact
> on performance because it requires SRCU to be used for synchronization.
> 
> * Static - callsites configuration and destination of debug logs
> can be configured only from a kernel boot command line. This option
> hides <debugfs>/dynamic_debug/control interface. It does not require
> SRCU synchronization because of the static configuration. It also
> provides convenient means to capture debug logs on production systems
> for issues which are difficult to reproduce but on the other hand
> do not expose <debugfs>/dynamic_debug/control interface for security
> reasons.
> 
> For example to capture thunderbolt subsystem debug logs on production
> system to trace instance named "thunderbolt":
> * enable kernel configuration option CONFIG_DYNAMIC_DEBUG_CORE,
> * enable kernel configuration option DYNAMIC_DEBUG_DST and set its
>    operation mode to Static.
> * add the option to the thunderbolt's drivers/thunderbolt/Makefile
> in order to compile in debug logs:
> 	CFLAGS_nhi.o := -DDYNAMIC_DEBUG_MODULE
> * compile the kernel and update it on a target device,
> * finally append the entry to the kernel boot command line:
> 	thunderbolt.dyndbg="dst trace:thunderbolt =p"
> 
> The DYNAMIC_DEBUG_DST option increases each callsite size by
> the pointer size.
> 
> Signed-off-by: Łukasz Bartosik <lb@semihalf.com>
> ---
> Changelog v1:
> - initial creation
> ---
>   include/linux/dynamic_debug.h |  30 ++
>   lib/Kconfig.debug             | 103 ++++++
>   lib/dynamic_debug.c           | 659 +++++++++++++++++++++++++++++++++-
>   3 files changed, 786 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
> index 41682278d2e8..8dee10f66e72 100644
> --- a/include/linux/dynamic_debug.h
> +++ b/include/linux/dynamic_debug.h
> @@ -38,8 +38,18 @@ struct _ddebug {
>   #define _DPRINTK_FLAGS_INCL_LINENO	(1<<3)
>   #define _DPRINTK_FLAGS_INCL_TID		(1<<4)
>   #define _DPRINTK_FLAGS_INCL_SOURCENAME	(1<<5)
>   
> +#if defined CONFIG_DYNAMIC_DEBUG_DST
> +	/*
> +	 * The 6th and 7th bits of the flags are used to determine
> +	 * destination of debug logs, currently supported destinations
> +	 * are defined in ddebug_dst_type enumeration
> +	 */
> +#define _DPRINTK_FLAGS_DST_SHIFT	6
> +#define _DPRINTK_FLAGS_DST_MASK	(3<<_DPRINTK_FLAGS_DST_SHIFT)
> +#endif
> +
>   #define _DPRINTK_FLAGS_INCL_ANY		\
>   	(_DPRINTK_FLAGS_INCL_MODNAME | _DPRINTK_FLAGS_INCL_FUNCNAME |\
>   	 _DPRINTK_FLAGS_INCL_LINENO  | _DPRINTK_FLAGS_INCL_TID |\
>   	 _DPRINTK_FLAGS_INCL_SOURCENAME)
> @@ -54,6 +64,10 @@ struct _ddebug {
>   		struct static_key_false dd_key_false;
>   	} key;
>   #endif
> +
> +#if defined CONFIG_DYNAMIC_DEBUG_DST
> +	struct ddebug_dst *dst;
> +#endif
>   } __attribute__((aligned(8)));
>   
>   enum class_map_type {
> @@ -280,10 +294,26 @@ void __dynamic_ibdev_dbg(struct _ddebug *descriptor,
>   	_dynamic_func_call(fmt, __dynamic_ibdev_dbg,		\
>   			   dev, fmt, ##__VA_ARGS__)
>   
> +#if defined CONFIG_DYNAMIC_DEBUG_DST
> +
> +void __print_hex_dump_dst(const struct _ddebug *descriptor, const char *level,
> +			  const char *prefix_str, int prefix_type, int rowsize,
> +			  int groupsize, const void *buf, size_t len,
> +			  bool ascii);
> +
> +#define dynamic_hex_dump(prefix_str, prefix_type, rowsize,				\
> +			 groupsize, buf, len, ascii)					\
> +	_dynamic_func_call(__builtin_constant_p(prefix_str) ? prefix_str : "hexdump",	\
> +			   __print_hex_dump_dst,					\
> +			   KERN_DEBUG, prefix_str, prefix_type,				\
> +			   rowsize, groupsize, buf, len, ascii)
> +#else
> +
>   #define dynamic_hex_dump(prefix_str, prefix_type, rowsize,		\
>   			 groupsize, buf, len, ascii)			\
>   	_dynamic_func_call_no_desc(__builtin_constant_p(prefix_str) ? prefix_str : "hexdump", \
>   				   print_hex_dump,			\
>   				   KERN_DEBUG, prefix_str, prefix_type,	\
>   				   rowsize, groupsize, buf, len, ascii)
> +#endif
>   
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index f0c30ad83f22..4abfa126bde5 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -188,6 +188,109 @@ config DYNAMIC_DEBUG_CORE
>   	  the case of embedded system where the kernel image size is
>   	  sensitive for people.
>   
> +menuconfig DYNAMIC_DEBUG_DST
> +	bool "Enable selection of dynamic debug logs destination"
> +	depends on DYNAMIC_DEBUG_CORE
> +	select TRACING
> +	help
> +	  Add support for selecting destination of dynamic debug logs.
> +	  When enabled it allows to configure destination of each callsite
> +	  individually. The option adds a framework (described by struct
> +	  ddebug_dst_ops) which provides flexible means to add a new destination
> +	  for debug logs. On top of the framework support for trace instance as
> +	  destination is added. By default destination of debug logs is syslog.
> +	  Syslog can be set explicitly by using dst keyword or is selected by
> +	  default when dst keyword is omitted, for example:
> +
> +	  localhost ~ # echo -n "module usbcore dst syslog =p" >
> +				  <debugfs>/dynamic_debug/control
> +	  or
> +
> +	  localhost ~ # echo -n "module usbcore =p" >
> +				  <debugfs>/dynamic_debug/control
> +
> +	  To enable a trace instance as a destination of debug logs a user
> +	  can for example issue the command:
> +
> +	  localhost ~ # echo -n "module usbcore dst trace:usb =p" >
> +				  <debugfs>/dynamic_debug/control
> +
> +	  The command will write debug logs from usbcore subsystem to the
> +	  trace instance named "usb" and the captured logs can be read
> +	  later with the command:
> +
> +	  localhost ~ # cat <debugfs>/tracing/instances/usb/trace
> +
> +	  When trace instance name is omitted the debug logs will be written
> +	  to "ddebug_default" trace instance:
> +
> +	  localhost ~ # cat <debugfs>/tracing/instances/ddebug_default/trace
> +
> +	  The DYNAMIC_DEBUG_DST option adds destination information
> +	  in the dynamic debug control:
> +
> +	  localhost ~ # cat  <debugfs>/dynamic_debug/control
> +	  # filename:lineno [module]function flags format destination
> +	  drivers/usb/core/usb-acpi.c:143 [usbcore]usb_acpi_set_power_state =p "acpi: power failed to be set\n" trace:usb
> +	  drivers/usb/core/usb-acpi.c:141 [usbcore]usb_acpi_set_power_state =p "acpi: power was set to %d\n" trace:usb
> +
> +	  The DYNAMIC_DEBUG_DST option increases each callsite size by
> +	  the pointer size.
> +
> +if DYNAMIC_DEBUG_DST
> +
> +choice
> +	prompt "Destination mode"
> +	default DYNAMIC_DEBUG_DST_DYNAMIC
> +	help
> +	  There are two modes of operation for dynamic debug logs destination
> +	  which can be selected during configuration stage of a kernel:
> +
> +	  * Dynamic - callsites configuration and destination of debug logs
> +	  can be dynamically changed during runtime. This has slight impact
> +	  on performance because it requires SRCU to be used for synchronization.
> +
> +	  * Static - callsites configuration and destination of debug logs
> +	  can be configured only from a kernel boot command line. This option
> +	  hides <debugfs>/dynamic_debug/control interface. It does not require
> +	  SRCU synchronization because of the static configuration. It also
> +	  provides convenient means to capture debug logs on production systems
> +	  for issues which are difficult to reproduce and at the same time
> +	  do not expose <debugfs>/dynamic_debug/control interface for security
> +	  reasons.
> +
> +config DYNAMIC_DEBUG_DST_DYNAMIC
> +	bool "Dynamic"
> +	select SRCU
> +	help
> +	  Callsites configuration and destination of debug logs can be
> +	  dynamically changed during runtime. This has slight impact on
> +	  performance because it requires SRCU to be used for synchronization.
> +
> +	  The interface which allows to dynamically change configuration is:
> +	        <debugfs>/dynamic_debug/control
> +
> +config DYNAMIC_DEBUG_DST_STATIC
> +	bool "Static"
> +	help
> +	  Callsites configuration and destination of debug logs can be
> +	  configured only from a kernel boot command line. This option
> +	  does not expose <debugfs>/dynamic_debug/control interface and
> +	  therefore does not require SRCU synchronization. It also provides
> +	  convenient means to capture debug logs on production systems
> +	  for issues which are difficult to reproduce and at the same time
> +	  do not expose <debugfs>/dynamic_debug/control interface
> +	  for security reasons.
> +
> +	  For example to configure usbcore module to output its debug logs
> +	  to trace instance named "usb" the following line would have to be
> +	  appended to a kernel boot command line:
> +
> +	      usbcore.dyndbg="dst trace:usb =p"
> +
> +endchoice
> +endif
> +
>   config SYMBOLIC_ERRNAME
>   	bool "Support symbolic error names in printf"
>   	default y if PRINTK
> diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
> index 009f2ead09c1..0cb69b553554 100644
> --- a/lib/dynamic_debug.c
> +++ b/lib/dynamic_debug.c
> @@ -44,6 +44,87 @@ extern struct _ddebug __stop___dyndbg[];
>   extern struct ddebug_class_map __start___dyndbg_classes[];
>   extern struct ddebug_class_map __stop___dyndbg_classes[];
>   
> +#if defined CONFIG_DYNAMIC_DEBUG_DST
> +#include <linux/trace.h>
> +
> +enum ddebug_dst_type {
> +	DDEBUG_DST_SYSLOG,	/* destination syslog */
> +	DDEBUG_DST_TRACE,	/* destination trace instance */
> +	/* DDEBUG_DST_NOT_USED_1 */
> +	/* DDEBUG_DST_NOT_USED_2 */
> +	DDEBUG_DST_MAX,
> +};
> +
> +/*
> + * The structure holds information related to debug logs output
> + * destination other than syslog. Currently only trace instance
> + * is supported.
> + */
> +struct ddebug_dst {
> +	unsigned int use_count;
> +	enum ddebug_dst_type type;
> +	struct ddebug_dst_ops *ops;
> +	union {
> +		struct {
> +			const char *instance;
> +			struct trace_array *arr;
> +		} trace;
> +	};
> +};
> +
> +#ifndef CONFIG_DYNAMIC_DEBUG_DST_STATIC
> +
> +/*
> + * Instead of slicing code with #ifdefs create
> + * wrappers around SRCU functions we use
> + */
> +DEFINE_STATIC_SRCU(dst_srcu);
> +
> +#define dd_srcu_dereference(p, ssp) srcu_dereference(p, ssp)
> +#define dd_rcu_assign_pointer(p, v) rcu_assign_pointer(p, v)
> +
> +static inline int dd_srcu_read_lock(struct srcu_struct *ssp)
> +{
> +	return srcu_read_lock(ssp);
> +}
> +
> +static inline void dd_srcu_read_unlock(struct srcu_struct *ssp, int idx)
> +{
> +	return srcu_read_unlock(ssp, idx);
> +}
> +
> +static void dd_synchronize_srcu(struct srcu_struct *ssp)
> +{
> +	synchronize_srcu(ssp);
> +}
> +
> +#else
> +
> +struct dd_srcu_struct {
> +};
> +
> +static struct dd_srcu_struct dst_srcu;
> +
> +#define dd_srcu_dereference(p, ssp) (p)
> +#define dd_rcu_assign_pointer(p, v) ((p) = (v))
> +
> +static inline int dd_srcu_read_lock(struct dd_srcu_struct *ssp)
> +{
> +	return 0;
> +}
> +
> +static inline void dd_srcu_read_unlock(struct dd_srcu_struct *ssp, int idx)
> +{
> +}
> +
> +void dd_synchronize_srcu(struct dd_srcu_struct *ssp)
> +{
> +}
> +
> +#endif /* CONFIG_DYNAMIC_DEBUG_DST_STATIC */
> +
> +#endif /* CONFIG_DYNAMIC_DEBUG_DST */
> +
>   struct ddebug_table {
>   	struct list_head link, maps;
>   	const char *mod_name;
> @@ -58,6 +139,7 @@ struct ddebug_query {
>   	const char *format;
>   	const char *class_string;
>   	unsigned int first_lineno, last_lineno;
> +	struct ddebug_dst *dst;
>   };
>   
>   struct ddebug_iter {
> @@ -126,10 +208,402 @@ do {								\
>   #define v3pr_info(fmt, ...)	vnpr_info(3, fmt, ##__VA_ARGS__)
>   #define v4pr_info(fmt, ...)	vnpr_info(4, fmt, ##__VA_ARGS__)
>   
> +#if defined CONFIG_DYNAMIC_DEBUG_DST
> +
> +static inline enum ddebug_dst_type get_dst_type(const struct _ddebug *dp)
> +{
> +	return (dp->flags & _DPRINTK_FLAGS_DST_MASK) >>
> +		_DPRINTK_FLAGS_DST_SHIFT;
> +}
> +
> +static void set_dst_type(unsigned int *newflags,
> +			 enum ddebug_dst_type type)
> +{
> +	*newflags &= ~_DPRINTK_FLAGS_DST_MASK;
> +	*newflags |= (type << _DPRINTK_FLAGS_DST_SHIFT);
> +}
> +
> +#define DST_SYSLOG_STR	"syslog"
> +#define DST_TRACE_STR	"trace"
> +#define DST_INVALID_STR	"invalid"
> +#define DST_DST_STR	"destination"
> +
> +struct dstbuf {
> +#define DST_DESC_MAX_SIZE 32
> +	char buf[DST_DESC_MAX_SIZE];
> +};
> +
> +static char *describe_dst_type(const enum ddebug_dst_type type)
> +{
> +	switch (type) {
> +	case DDEBUG_DST_SYSLOG:
> +		return DST_SYSLOG_STR;
> +	case DDEBUG_DST_TRACE:
> +		return DST_TRACE_STR;
> +	default:
> +		return DST_INVALID_STR;
> +	}
> +}
> +
> +static char *ddebug_describe_dst(const struct ddebug_dst *dst,
> +				 struct dstbuf *dstb)
> +{
> +	if (!dst)
> +		return DST_SYSLOG_STR;
> +
> +	switch (dst->type) {
> +	case DDEBUG_DST_SYSLOG:
> +		return DST_SYSLOG_STR;
> +	case DDEBUG_DST_TRACE:
> +		snprintf(dstb->buf, DST_DESC_MAX_SIZE, "%s:%s",
> +			 DST_TRACE_STR, dst->trace.instance);
> +		break;
> +	default:
> +		return DST_INVALID_STR;
> +	}
> +
> +	return dstb->buf;
> +}
> +
> +static char *ddebug_describe_dst_dp(struct _ddebug *dp, struct dstbuf *dstb)
> +{
> +	if (!get_dst_type(dp))
> +		return DST_SYSLOG_STR;
> +
> +	return ddebug_describe_dst(dp->dst, dstb);
> +}
> +
> +/*
> + * struct ddebug_dst_ops - dynamic debug logs destination operations
> + *
> + * @parse_and_init - parses and initializes destination
> + * @has_changed - checks whether destination has changed for a callsite
> + * @print - prints message for a callsite
> + * @dev_print - prints device message for a callsite
> + * @free - frees memory associated with a destination
> + */
> +struct ddebug_dst_ops {
> +	int (*parse_and_init)(struct ddebug_query *query, const char *arg);
> +	bool (*has_changed)(const struct ddebug_query *query,
> +			    const struct _ddebug *dp);
> +	void (*print)(const struct ddebug_dst *dst, const char *fmt, ...);
> +	void (*dev_print)(const struct ddebug_dst *dst,
> +			  const struct device *dev, const char *fmt, ...);
> +	void (*free)(struct ddebug_dst *dst, int arg);
> +};
> +
> +static int tr_parse_and_init(struct ddebug_query *query,
> +			     const char *arg)
> +{
> +	char *instance = strchr(arg, ':');
> +	struct trace_array *arr;
> +	int ret = -EINVAL;
> +
> +	if (instance)
> +		instance++;
> +	else
> +		instance = "ddebug_default";
> +
> +	arr = trace_array_get_by_name(instance);
> +	if (!arr)
> +		goto err;
> +
> +	ret = trace_array_init_printk(arr);
> +	if (ret)
> +		goto err_trace;
> +
> +	query->dst->trace.instance = kstrdup(instance, GFP_KERNEL);
> +	if (!query->dst->trace.instance)
> +		goto err_trace;
> +
> +	query->dst->trace.arr = arr;
> +
> +	v3pr_info("parsed trace dst: instance name=%s, arrray=%p\n",
> +		  query->dst->trace.instance, arr);
> +	return 0;
> +err_trace:
> +	trace_array_put(arr);
> +	trace_array_destroy(arr);
> +err:
> +	return ret;
> +}
> +
> +bool tr_has_changed(const struct ddebug_query *query, const struct _ddebug *dp)
> +{
> +	if (!dp->dst)
> +		return true;
> +	else if (dp->dst->type != DDEBUG_DST_TRACE)
> +		return true;
> +
> +	return query->dst->trace.arr != dp->dst->trace.arr;
> +}
> +
> +__printf(2, 3)
> +static void tr_print(const struct ddebug_dst *dst, const char *fmt, ...)
> +{
> +	va_list args;
> +	struct va_format vaf;
> +
> +	va_start(args, fmt);
> +	vaf.fmt = fmt;
> +	vaf.va = &args;
> +
> +	trace_array_printk(dst->trace.arr, _THIS_IP_, "%pV", &vaf);
> +
> +	va_end(args);
> +}
> +
> +__printf(3, 4)
> +static void tr_dev_print(const struct ddebug_dst *dst,
> +			 const struct device *dev, const char *fmt, ...)
> +{
> +	va_list args;
> +	struct va_format vaf;
> +
> +	va_start(args, fmt);
> +	vaf.fmt = fmt;
> +	vaf.va = &args;
> +
> +	trace_array_printk(dst->trace.arr, _THIS_IP_, "%pV", &vaf);
> +	va_end(args);
> +}
> +
> +static void tr_free(struct ddebug_dst *dst, int tr_arr_destroy)
> +{
> +	WARN_ON(!dst);
> +
> +	v2pr_info("freed dst: type=trace, instance=%s\n", dst->trace.instance);
> +
> +	kfree(dst->trace.instance);
> +	dst->trace.instance = NULL;
> +
> +	trace_array_put(dst->trace.arr);
> +	/*
> +	 * destroy trace instance in case when query was not applied to any
> +	 * of the callsites, otherwise don't try to destroy it because it will
> +	 * be removed from sysfs together with captured debug logs, let a user
> +	 * to delete it manually later at convenient time
> +	 */
> +	if (tr_arr_destroy)
> +		trace_array_destroy(dst->trace.arr);
> +	dst->trace.arr = NULL;
> +}
> +
> +bool syslog_has_changed(const struct ddebug_query *query,
> +			const struct _ddebug *dp)
> +{
> +	if (!dp->dst)
> +		return false;
> +
> +	return dp->dst->type != DDEBUG_DST_SYSLOG;
> +}
> +
> +static void syslog_free(struct ddebug_dst *dst, int arg)
> +{
> +	v2pr_info("freed dst: type=syslog\n");
> +}
> +
> +static struct ddebug_dst_ops dst_ops[] = {
> +	// syslog destination ops
> +	{
> +		.parse_and_init = NULL,
> +		.has_changed = syslog_has_changed,
> +		.print = NULL,
> +		.dev_print = NULL,
> +		.free = syslog_free,
> +	},
> +	// trace destination ops
> +	{
> +		.parse_and_init = tr_parse_and_init,
> +		.has_changed = tr_has_changed,
> +		.print = tr_print,
> +		.dev_print = tr_dev_print,
> +		.free = tr_free,
> +	},
> +};
> +
> +static int dst_parse_and_init(struct ddebug_query *query, const char *arg)
> +{
> +	int ret = -EINVAL;
> +
> +	if (!arg)
> +		goto err;
> +
> +	if (query->dst)
> +		goto err;
> +
> +	query->dst = kzalloc(sizeof(struct ddebug_dst), GFP_KERNEL);
> +	if (!query->dst) {
> +		ret = -ENOMEM;
> +		goto err;
> +	}
> +
> +	if (!strcmp(arg, "syslog")) {
> +		query->dst->type = DDEBUG_DST_SYSLOG;
> +		query->dst->ops = &dst_ops[DDEBUG_DST_SYSLOG];
> +	} else if (!strcmp(arg, "trace") ||
> +		   !strncmp(arg, "trace:", 6)) {
> +		query->dst->type = DDEBUG_DST_TRACE;
> +		query->dst->ops = &dst_ops[DDEBUG_DST_TRACE];
> +	} else
> +		goto err_mem;
> +
> +	if (query->dst->ops->parse_and_init) {
> +		ret = query->dst->ops->parse_and_init(query, arg);
> +		if (ret)
> +			goto err_mem;
> +	}
> +
> +	v3pr_info("parsed dst: type=%s\n", describe_dst_type(query->dst->type));
> +	return 0;
> +err_mem:
> +	kfree(query->dst);
> +err:
> +	return ret;
> +}
> +
> +static void dst_apply_change(const struct ddebug_query *query,
> +			     struct _ddebug *dp)
> +{
> +	/* store old destination pointer */
> +	struct ddebug_dst *old_dst = dp->dst;
> +	struct ddebug_dst *new_dst;
> +
> +	/* increase use count */
> +	query->dst->use_count++;
> +
> +	/*
> +	 * syslog destination does not require additional description
> +	 * however we use it to simplify control path processing
> +	 */
> +	new_dst = (query->dst->type == DDEBUG_DST_SYSLOG) ? NULL : query->dst;
> +
> +	/* update destination pointer */
> +	dd_rcu_assign_pointer(dp->dst, new_dst);
> +
> +	if (!old_dst)
> +		return;
> +
> +	old_dst->use_count--;
> +	/* check if old destination pointer is still being used */
> +	if (!old_dst->use_count) {
> +		/*
> +		 * wait for all read rcu critical sections
> +		 * in progress to finish
> +		 */
> +		dd_synchronize_srcu(&dst_srcu);
> +		/* call destination specific free function */
> +		old_dst->ops->free(old_dst, 0);
> +		/* free old destination pointer */
> +		kfree(old_dst);
> +	}
> +}
> +
> +static void dst_try_free(struct ddebug_query *query)
> +{
> +	if (!query)
> +		return;
> +
> +	/* free destination if it wasn't applied to any callsite */
> +	if (!query->dst->use_count) {
> +		if (query->dst->ops->free)
> +			query->dst->ops->free(query->dst, 1);
> +		/*
> +		 * for syslog we always free its destination because
> +		 * it is used only to simplify control path processing
> +		 */
> +		if (query->dst->type)
> +			v2pr_info("freed dst: didn't apply to any of the callsites\n");
> +		kfree(query->dst);
> +		query->dst = NULL;
> +	}
> +}
> +
> +void __print_hex_dump_dst(const struct _ddebug *descriptor, const char *level,
> +			  const char *prefix_str, int prefix_type,
> +			  int rowsize, int groupsize, const void *buf,
> +			  size_t len, bool ascii)
> +{
> +	if (get_dst_type(descriptor)) {
> +		const u8 *ptr = buf;
> +		struct ddebug_dst *dst;
> +		int i, linelen, remaining = len, idx;
> +		unsigned char linebuf[32 * 3 + 2 + 32 + 1];
> +
> +		if (rowsize != 16 && rowsize != 32)
> +			rowsize = 16;
> +
> +		idx = dd_srcu_read_lock(&dst_srcu);
> +		dst = dd_srcu_dereference(descriptor->dst, &dst_srcu);
> +		WARN_ON(!dst);
> +		for (i = 0; i < len; i += rowsize) {
> +			linelen = min(remaining, rowsize);
> +			remaining -= rowsize;
> +
> +			hex_dump_to_buffer(ptr + i, linelen, rowsize, groupsize,
> +					   linebuf, sizeof(linebuf), ascii);
> +
> +			switch (prefix_type) {
> +			case DUMP_PREFIX_ADDRESS:
> +				dst->ops->print(descriptor->dst, "%s%s%p: %s\n",
> +						level, prefix_str, ptr + i, linebuf);
> +				break;
> +			case DUMP_PREFIX_OFFSET:
> +				dst->ops->print(descriptor->dst, "%s%s%.8x: %s\n",
> +						level, prefix_str, i, linebuf);
> +				break;
> +			default:
> +				dst->ops->print(descriptor->dst, "%s%s%s\n",
> +						level, prefix_str, linebuf);
> +				break;
> +			}
> +		}
> +
> +		dd_srcu_read_unlock(&dst_srcu, idx);
> +	} else
> +		print_hex_dump(level, prefix_str, prefix_type, rowsize,
> +			       groupsize, buf, len, ascii);
> +}
> +EXPORT_SYMBOL(__print_hex_dump_dst);
> +
> +#else
> +
> +struct ddebug_dst {
> +};
> +
> +struct dstbuf {
> +};
> +
> +static inline unsigned int get_dst_type(const struct _ddebug *dp)
> +{
> +	return  0;
> +}
> +
> +static char *ddebug_describe_dst(const struct ddebug_dst *dst,
> +				 struct dstbuf *dstb)
> +{
> +	return "";
> +}
> +
> +static char *ddebug_describe_dst_dp(struct _ddebug *dp,
> +				    struct dstbuf *dstb)
> +{
> +	return "";
> +}
> +
> +static void dst_try_free(struct ddebug_query *query)
> +{
> +}
> +
> +#define DST_DST_STR	""
> +
> +#endif /* CONFIG_DYNAMIC_DEBUG_DST */
> +
>   static void vpr_info_dq(const struct ddebug_query *query, const char *msg)
>   {
>   	/* trim any trailing newlines */
>   	int fmtlen = 0;
> +	struct dstbuf dstb;
>   
>   	if (query->format) {
>   		fmtlen = strlen(query->format);
> @@ -137,13 +611,14 @@ static void vpr_info_dq(const struct ddebug_query *query, const char *msg)
>   			fmtlen--;
>   	}
>   
> -	v3pr_info("%s: func=\"%s\" file=\"%s\" module=\"%s\" format=\"%.*s\" lineno=%u-%u class=%s\n",
> +	v3pr_info("%s: func=\"%s\" file=\"%s\" module=\"%s\" format=\"%.*s\" lineno=%u-%u class=%s %s=%s\n",
>   		  msg,
>   		  query->function ?: "",
>   		  query->filename ?: "",
>   		  query->module ?: "",
>   		  fmtlen, query->format ?: "",
> -		  query->first_lineno, query->last_lineno, query->class_string);
> +		  query->first_lineno, query->last_lineno, query->class_string,
> +		  DST_DST_STR, ddebug_describe_dst(query->dst, &dstb));
>   }
>   
>   static struct ddebug_class_map *ddebug_find_valid_class(struct ddebug_table const *dt,
> @@ -178,8 +653,12 @@ static int ddebug_change(const struct ddebug_query *query,
>   	unsigned int newflags;
>   	unsigned int nfound = 0;
>   	struct flagsbuf fbuf, nbuf;
> +	struct dstbuf dstbc, dstbn;
>   	struct ddebug_class_map *map = NULL;
>   	int __outvar valid_class;
> +#if defined CONFIG_DYNAMIC_DEBUG_DST
> +	struct ddebug_dst_ops *dst_ops = query->dst->ops;
> +#endif
>   
>   	/* search for matching ddebugs */
>   	mutex_lock(&ddebug_lock);
> @@ -243,8 +722,19 @@ static int ddebug_change(const struct ddebug_query *query,
>   			nfound++;
>   
>   			newflags = (dp->flags & modifiers->mask) | modifiers->flags;
> +#if defined CONFIG_DYNAMIC_DEBUG_DST
> +			/* set destination type in newflags */
> +			set_dst_type(&newflags, query->dst->type);
> +			if (newflags == dp->flags &&
> +			    (!dst_ops->has_changed ||
> +			     !dst_ops->has_changed(query, dp)))
> +				/* nothing changed */
> +				continue;
> +#else
>   			if (newflags == dp->flags)
>   				continue;
> +#endif
> +
>   #ifdef CONFIG_JUMP_LABEL
>   			if (dp->flags & _DPRINTK_FLAGS_PRINT) {
>   				if (!(newflags & _DPRINTK_FLAGS_PRINT))
> @@ -253,14 +743,24 @@ static int ddebug_change(const struct ddebug_query *query,
>   				static_branch_enable(&dp->key.dd_key_true);
>   			}
>   #endif
> -			v4pr_info("changed %s:%d [%s]%s %s => %s\n",
> +			v4pr_info("changed %s:%d [%s]%s %s %s => %s %s\n",
>   				  trim_prefix(dp->filename), dp->lineno,
>   				  dt->mod_name, dp->function,
>   				  ddebug_describe_flags(dp->flags, &fbuf),
> -				  ddebug_describe_flags(newflags, &nbuf));
> +				  ddebug_describe_dst_dp(dp, &dstbc),
> +				  ddebug_describe_flags(newflags, &nbuf),
> +				  ddebug_describe_dst(query->dst, &dstbn));
>   			dp->flags = newflags;
> +
> +#if defined CONFIG_DYNAMIC_DEBUG_DST
> +			if (dst_ops->has_changed &&
> +			    dst_ops->has_changed(query, dp))
> +				/* destination changed, apply it */
> +				dst_apply_change(query, dp);
> +#endif
>   		}
>   	}
> +
>   	mutex_unlock(&ddebug_lock);
>   
>   	if (!nfound && verbose)
> @@ -456,6 +956,12 @@ static int ddebug_parse_query(char *words[], int nwords,
>   				return -EINVAL;
>   		} else if (!strcmp(keyword, "class")) {
>   			rc = check_set(&query->class_string, arg, "class");
> +#if defined CONFIG_DYNAMIC_DEBUG_DST
> +		} else if (!strcmp(keyword, "dst")) {
> +			rc = dst_parse_and_init(query, arg);
> +			if (rc)
> +				return rc;
> +#endif
>   		} else {
>   			pr_err("unknown keyword \"%s\"\n", keyword);
>   			return -EINVAL;
> @@ -463,6 +969,15 @@ static int ddebug_parse_query(char *words[], int nwords,
>   		if (rc)
>   			return rc;
>   	}
> +
> +#if defined CONFIG_DYNAMIC_DEBUG_DST
> +	/* set destination to syslog by default if it was not explicitly set */
> +	if (!query->dst) {
> +		rc = dst_parse_and_init(query, "syslog");
> +		if (rc)
> +			return rc;
> +	}
> +#endif
>   	if (!query->module && modname)
>   		/*
>   		 * support $modname.dyndbg=<multiple queries>, when
> @@ -549,11 +1064,14 @@ static int ddebug_exec_query(char *query_string, const char *modname)
>   	}
>   	if (ddebug_parse_query(words, nwords-1, &query, modname)) {
>   		pr_err("query parse failed\n");
> +		dst_try_free(&query);
>   		return -EINVAL;
>   	}
> +
>   	/* actually go and implement the change */
>   	nfound = ddebug_change(&query, &modifiers);
>   	vpr_info_dq(&query, nfound ? "applied" : "no-match");
> +	dst_try_free(&query);
>   
>   	return nfound;
>   }
> @@ -856,6 +1374,10 @@ static inline char *dynamic_emit_prefix(struct _ddebug *desc, char *buf)
>   
>   void __dynamic_pr_debug(struct _ddebug *descriptor, const char *fmt, ...)
>   {
> +#if defined CONFIG_DYNAMIC_DEBUG_DST
> +	struct ddebug_dst *dst;
> +	int idx;
> +#endif
>   	va_list args;
>   	struct va_format vaf;
>   	char buf[PREFIX_SIZE] = "";
> @@ -868,6 +1390,21 @@ void __dynamic_pr_debug(struct _ddebug *descriptor, const char *fmt, ...)
>   	vaf.fmt = fmt;
>   	vaf.va = &args;
>   
> +#if defined CONFIG_DYNAMIC_DEBUG_DST
> +	if (!get_dst_type(descriptor))
> +		goto syslog;
> +
> +	idx = dd_srcu_read_lock(&dst_srcu);
> +	dst = dd_srcu_dereference(descriptor->dst, &dst_srcu);
> +	WARN_ON(!dst);
> +	dst->ops->print(dst, "%s%pV", dynamic_emit_prefix(descriptor, buf),
> +			&vaf);
> +
> +	dd_srcu_read_unlock(&dst_srcu, idx);
> +	va_end(args);
> +	return;
> +syslog:
> +#endif
>   	printk(KERN_DEBUG "%s%pV", dynamic_emit_prefix(descriptor, buf), &vaf);
>   
>   	va_end(args);
> @@ -877,6 +1414,10 @@ EXPORT_SYMBOL(__dynamic_pr_debug);
>   void __dynamic_dev_dbg(struct _ddebug *descriptor,
>   		      const struct device *dev, const char *fmt, ...)
>   {
> +#if defined CONFIG_DYNAMIC_DEBUG_DST
> +	struct ddebug_dst *dst;
> +	int idx;
> +#endif
>   	struct va_format vaf;
>   	va_list args;
>   
> @@ -888,6 +1429,29 @@ void __dynamic_dev_dbg(struct _ddebug *descriptor,
>   	vaf.fmt = fmt;
>   	vaf.va = &args;
>   
> +#if defined CONFIG_DYNAMIC_DEBUG_DST
> +	if (!get_dst_type(descriptor))
> +		goto syslog;
> +
> +	idx = dd_srcu_read_lock(&dst_srcu);
> +	dst = dd_srcu_dereference(descriptor->dst, &dst_srcu);
> +	WARN_ON(!dst);
> +	if (!dev) {
> +		dst->ops->print(dst, "(NULL device *): %pV", &vaf);
> +	} else {
> +		char buf[PREFIX_SIZE] = "";
> +
> +		dst->ops->dev_print(dst, dev, "%s%s %s: %pV",
> +				    dynamic_emit_prefix(descriptor, buf),
> +				    dev_driver_string(dev), dev_name(dev),
> +				    &vaf);
> +	}
> +
> +	dd_srcu_read_unlock(&dst_srcu, idx);
> +	va_end(args);
> +	return;
> +syslog:
> +#endif
>   	if (!dev) {
>   		printk(KERN_DEBUG "(NULL device *): %pV", &vaf);
>   	} else {
> @@ -908,6 +1472,10 @@ EXPORT_SYMBOL(__dynamic_dev_dbg);
>   void __dynamic_netdev_dbg(struct _ddebug *descriptor,
>   			  const struct net_device *dev, const char *fmt, ...)
>   {
> +#if defined CONFIG_DYNAMIC_DEBUG_DST
> +	struct ddebug_dst *dst;
> +	int idx;
> +#endif
>   	struct va_format vaf;
>   	va_list args;
>   
> @@ -919,6 +1487,35 @@ void __dynamic_netdev_dbg(struct _ddebug *descriptor,
>   	vaf.fmt = fmt;
>   	vaf.va = &args;
>   
> +#if defined CONFIG_DYNAMIC_DEBUG_DST
> +	if (!get_dst_type(descriptor))
> +		goto syslog;
> +
> +	idx = dd_srcu_read_lock(&dst_srcu);
> +	dst = dd_srcu_dereference(descriptor->dst, &dst_srcu);
> +	WARN_ON(!dst);
> +	if (dev && dev->dev.parent) {
> +		char buf[PREFIX_SIZE] = "";
> +
> +		dst->ops->dev_print(dst, dev->dev.parent,
> +				    "%s%s %s %s%s: %pV",
> +				    dynamic_emit_prefix(descriptor, buf),
> +				    dev_driver_string(dev->dev.parent),
> +				    dev_name(dev->dev.parent),
> +				    netdev_name(dev), netdev_reg_state(dev),
> +				    &vaf);
> +	} else if (dev) {
> +		dst->ops->print(dst, "%s%s: %pV", netdev_name(dev),
> +				netdev_reg_state(dev), &vaf);
> +	} else {
> +		dst->ops->print(dst, "(NULL net_device *): %pV", &vaf);
> +	}
> +
> +	dd_srcu_read_unlock(&dst_srcu, idx);
> +	va_end(args);
> +	return;
> +syslog:
> +#endif
>   	if (dev && dev->dev.parent) {
>   		char buf[PREFIX_SIZE] = "";
>   
> @@ -947,6 +1544,10 @@ EXPORT_SYMBOL(__dynamic_netdev_dbg);
>   void __dynamic_ibdev_dbg(struct _ddebug *descriptor,
>   			 const struct ib_device *ibdev, const char *fmt, ...)
>   {
> +#if defined CONFIG_DYNAMIC_DEBUG_DST
> +	struct ddebug_dst *dst;
> +	int idx;
> +#endif
>   	struct va_format vaf;
>   	va_list args;
>   
> @@ -955,6 +1556,34 @@ void __dynamic_ibdev_dbg(struct _ddebug *descriptor,
>   	vaf.fmt = fmt;
>   	vaf.va = &args;
>   
> +#if defined CONFIG_DYNAMIC_DEBUG_DST
> +	if (!get_dst_type(descriptor))
> +		goto syslog;
> +
> +	idx = dd_srcu_read_lock(&dst_srcu);
> +	dst = dd_srcu_dereference(descriptor->dst, &dst_srcu);
> +	WARN_ON(!dst);
> +	if (ibdev && ibdev->dev.parent) {
> +		char buf[PREFIX_SIZE] = "";
> +
> +		dst->ops->dev_print(dst, ibdev->dev.parent,
> +				    "%s%s %s %s: %pV",
> +				    dynamic_emit_prefix(descriptor, buf),
> +				    dev_driver_string(ibdev->dev.parent),
> +				    dev_name(ibdev->dev.parent),
> +				    dev_name(&ibdev->dev),
> +				    &vaf);
> +	} else if (ibdev) {
> +		dst->ops->print(dst, "%s: %pV", dev_name(&ibdev->dev), &vaf);
> +	} else {
> +		dst->ops->print(dst, "(NULL ib_device): %pV", &vaf);
> +	}
> +
> +	dd_srcu_read_unlock(&dst_srcu, idx);
> +	va_end(args);
> +	return;
> +syslog:
> +#endif
>   	if (ibdev && ibdev->dev.parent) {
>   		char buf[PREFIX_SIZE] = "";
>   
> @@ -1127,11 +1756,16 @@ static int ddebug_proc_show(struct seq_file *m, void *p)
>   	struct ddebug_iter *iter = m->private;
>   	struct _ddebug *dp = p;
>   	struct flagsbuf flags;
> +	struct dstbuf dstb;
>   	char const *class;
>   
>   	if (p == SEQ_START_TOKEN) {
> -		seq_puts(m,
> -			 "# filename:lineno [module]function flags format\n");
> +		seq_puts(m, "# filename:lineno [module]function flags format");
> +#if defined CONFIG_DYNAMIC_DEBUG_DST
> +		seq_puts(m, " destination\n");
> +#else
> +		seq_puts(m, "\n");
> +#endif
>   		return 0;
>   	}
>   
> @@ -1149,6 +1783,7 @@ static int ddebug_proc_show(struct seq_file *m, void *p)
>   		else
>   			seq_printf(m, " class unknown, _id:%d", dp->class_id);
>   	}
> +	seq_printf(m, " %s", ddebug_describe_dst_dp(dp, &dstb));
>   	seq_puts(m, "\n");
>   
>   	return 0;
> @@ -1351,6 +1986,9 @@ static void ddebug_remove_all_tables(void)
>   
>   static __initdata int ddebug_init_success;
>   
> +
> +#ifndef CONFIG_DYNAMIC_DEBUG_DST_STATIC
> +
>   static int __init dynamic_debug_init_control(void)
>   {
>   	struct proc_dir_entry *procfs_dir;
> @@ -1374,6 +2012,15 @@ static int __init dynamic_debug_init_control(void)
>   	return 0;
>   }
>   
> +#else
> +
> +static int __init dynamic_debug_init_control(void)
> +{
> +	return 0;
> +}
> +
> +#endif
> +
>   static int __init dynamic_debug_init(void)
>   {
>   	struct _ddebug *iter, *iter_mod_start;
