Return-Path: <linux-kernel+bounces-97245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0165F87677A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 16:40:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB167286558
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 15:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 372031F94C;
	Fri,  8 Mar 2024 15:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IS0Ir728"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E041F932;
	Fri,  8 Mar 2024 15:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709912402; cv=none; b=qE0woWYra3Ui8VJjvM1C9UEoLOQ/S1ll+SA2I806EncXF0BwlGCuf9EMiOzupakNwB2UqyeIurHXcBYtQ4coi2kAcFvybk2ATTfNSfak37l3MIXmlal06q64MPlBgxpunw/fZZNl8RDA1kXn0ro++vysh0BBdj0WYQjqPywC3W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709912402; c=relaxed/simple;
	bh=0eO6xOMRUPVlNM3MVHgcheRlmwso//Cdy89FhcriVGE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kJo/TwKced8n2+7wQds087XatBDLvCLUJcaGVgCY5BCs+HVnTeRhsiRc1yZuT4/TjRwwDuEa+uNhu3d1SVDtA2TVD4fcXnrWgl3KZ4R4dKYadjeom83O6aoqWmzPEvWN0w/lEmzVcEKIq4eSSUvyyZPT+kET6tCTpr9MScKwvro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IS0Ir728; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709912399; x=1741448399;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0eO6xOMRUPVlNM3MVHgcheRlmwso//Cdy89FhcriVGE=;
  b=IS0Ir7287xlo04jdse7gP51wK8ux56frxMwLVJ/FUXCbhTY28SI6YsnT
   ATMNgPcPnwc2RBqpDsvKd9lS6m6l5+CzdF5xMfW9E2mLMz/X30MfZpYtV
   tzUzwu1bJQUvqV07kYSv4S01RMUWpq6HGyd4fOMhhZZBNw5TioYEt+/qX
   l7/rojET0HBdNtqfQYwPdyfScsX/KfTz66aJ1Pet3QEKq5OzOR+MXPAvA
   WOcmCnBINdIabvajdIjbvr0v1L6LKiFrXd7lvUs2DoF80vk5K5/wgtJch
   loGCjBdjt3DUhBG13zq4DstJHra2qbA8QzY6vVQ0g1VYKZohpVlFfANAE
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="8454477"
X-IronPort-AV: E=Sophos;i="6.07,109,1708416000"; 
   d="scan'208";a="8454477"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2024 07:39:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,110,1708416000"; 
   d="scan'208";a="10596160"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 08 Mar 2024 07:39:53 -0800
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ricK6-0006TI-2d;
	Fri, 08 Mar 2024 15:39:50 +0000
Date: Fri, 8 Mar 2024 23:39:08 +0800
From: kernel test robot <lkp@intel.com>
To: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>,
	Vincent Donnefort <vdonnefort@google.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, suleiman@google.com,
	Thomas Gleixner <tglx@linutronix.de>,
	Vineeth Pillai <vineeth@bitbyteword.org>,
	Youssef Esmat <youssefesmat@google.com>,
	Beau Belgrave <beaub@linux.microsoft.com>,
	Alexander Graf <graf@amazon.com>, Baoquan He <bhe@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 8/8] ring-buffer: Validate boot range memory events
Message-ID: <202403082327.SiOUrqxy-lkp@intel.com>
References: <20240306020006.586558735@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240306020006.586558735@goodmis.org>

Hi Steven,

kernel test robot noticed the following build errors:

[auto build test ERROR on next-20240305]
[cannot apply to tip/x86/core akpm-mm/mm-everything linus/master v6.8-rc7 v6.8-rc6 v6.8-rc5 v6.8-rc7]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Steven-Rostedt/ring-buffer-Allow-mapped-field-to-be-set-without-mapping/20240306-100047
base:   next-20240305
patch link:    https://lore.kernel.org/r/20240306020006.586558735%40goodmis.org
patch subject: [PATCH 8/8] ring-buffer: Validate boot range memory events
config: microblaze-allmodconfig (https://download.01.org/0day-ci/archive/20240308/202403082327.SiOUrqxy-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240308/202403082327.SiOUrqxy-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403082327.SiOUrqxy-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   kernel/trace/ring_buffer.c: In function 'rb_read_data_buffer':
>> kernel/trace/ring_buffer.c:1629:29: error: 'cpu_buffer' undeclared (first use in this function)
    1629 |                 atomic_inc(&cpu_buffer->record_disabled);               \
         |                             ^~~~~~~~~~
   kernel/trace/ring_buffer.c:1667:33: note: in expansion of macro 'buffer_warn_return'
    1667 |                                 buffer_warn_return("[CPU: %d]ABSOLUTE TIME WENT BACKWARDS: last ts: %lld absolute ts: %lld\n",
         |                                 ^~~~~~~~~~~~~~~~~~
   kernel/trace/ring_buffer.c:1629:29: note: each undeclared identifier is reported only once for each function it appears in
    1629 |                 atomic_inc(&cpu_buffer->record_disabled);               \
         |                             ^~~~~~~~~~
   kernel/trace/ring_buffer.c:1667:33: note: in expansion of macro 'buffer_warn_return'
    1667 |                                 buffer_warn_return("[CPU: %d]ABSOLUTE TIME WENT BACKWARDS: last ts: %lld absolute ts: %lld\n",
         |                                 ^~~~~~~~~~~~~~~~~~
>> kernel/trace/ring_buffer.c:1631:17: error: implicit declaration of function 'dump_buffer_page'; did you mean 'free_buffer_page'? [-Werror=implicit-function-declaration]
    1631 |                 dump_buffer_page(bpage, info, tail);                    \
         |                 ^~~~~~~~~~~~~~~~
   kernel/trace/ring_buffer.c:1667:33: note: in expansion of macro 'buffer_warn_return'
    1667 |                                 buffer_warn_return("[CPU: %d]ABSOLUTE TIME WENT BACKWARDS: last ts: %lld absolute ts: %lld\n",
         |                                 ^~~~~~~~~~~~~~~~~~
>> kernel/trace/ring_buffer.c:1631:34: error: 'bpage' undeclared (first use in this function); did you mean 'dpage'?
    1631 |                 dump_buffer_page(bpage, info, tail);                    \
         |                                  ^~~~~
   kernel/trace/ring_buffer.c:1667:33: note: in expansion of macro 'buffer_warn_return'
    1667 |                                 buffer_warn_return("[CPU: %d]ABSOLUTE TIME WENT BACKWARDS: last ts: %lld absolute ts: %lld\n",
         |                                 ^~~~~~~~~~~~~~~~~~
>> kernel/trace/ring_buffer.c:1631:41: error: 'info' undeclared (first use in this function)
    1631 |                 dump_buffer_page(bpage, info, tail);                    \
         |                                         ^~~~
   kernel/trace/ring_buffer.c:1667:33: note: in expansion of macro 'buffer_warn_return'
    1667 |                                 buffer_warn_return("[CPU: %d]ABSOLUTE TIME WENT BACKWARDS: last ts: %lld absolute ts: %lld\n",
         |                                 ^~~~~~~~~~~~~~~~~~
>> kernel/trace/ring_buffer.c:1636:25: warning: 'return' with no value, in function returning non-void [-Wreturn-type]
    1636 |                         return;                                         \
         |                         ^~~~~~
   kernel/trace/ring_buffer.c:1667:33: note: in expansion of macro 'buffer_warn_return'
    1667 |                                 buffer_warn_return("[CPU: %d]ABSOLUTE TIME WENT BACKWARDS: last ts: %lld absolute ts: %lld\n",
         |                                 ^~~~~~~~~~~~~~~~~~
   kernel/trace/ring_buffer.c:1642:12: note: declared here
    1642 | static int rb_read_data_buffer(struct buffer_data_page *dpage, int tail, int cpu,
         |            ^~~~~~~~~~~~~~~~~~~
>> kernel/trace/ring_buffer.c:1667:33: error: label 'out' used but not defined
    1667 |                                 buffer_warn_return("[CPU: %d]ABSOLUTE TIME WENT BACKWARDS: last ts: %lld absolute ts: %lld\n",
         |                                 ^~~~~~~~~~~~~~~~~~
   kernel/trace/ring_buffer.c: In function 'rb_set_commit_to_write':
   kernel/trace/ring_buffer.c:3588:45: warning: assignment to 'long unsigned int' from 'struct buffer_data_page *' makes integer from pointer without a cast [-Wint-conversion]
    3588 |                         meta->commit_buffer = cpu_buffer->commit_page->page;
         |                                             ^
   kernel/trace/ring_buffer.c: At top level:
>> kernel/trace/ring_buffer.c:3957:13: warning: conflicting types for 'dump_buffer_page'; have 'void(struct buffer_data_page *, struct rb_event_info *, long unsigned int)'
    3957 | static void dump_buffer_page(struct buffer_data_page *bpage,
         |             ^~~~~~~~~~~~~~~~
>> kernel/trace/ring_buffer.c:3957:13: error: static declaration of 'dump_buffer_page' follows non-static declaration
   kernel/trace/ring_buffer.c:1631:17: note: previous implicit declaration of 'dump_buffer_page' with type 'void(struct buffer_data_page *, struct rb_event_info *, long unsigned int)'
    1631 |                 dump_buffer_page(bpage, info, tail);                    \
         |                 ^~~~~~~~~~~~~~~~
   kernel/trace/ring_buffer.c:1667:33: note: in expansion of macro 'buffer_warn_return'
    1667 |                                 buffer_warn_return("[CPU: %d]ABSOLUTE TIME WENT BACKWARDS: last ts: %lld absolute ts: %lld\n",
         |                                 ^~~~~~~~~~~~~~~~~~
   kernel/trace/ring_buffer.c: In function 'check_buffer':
>> kernel/trace/ring_buffer.c:4046:9: error: 'ret' undeclared (first use in this function); did you mean 'net'?
    4046 |         ret = rb_read_data_buffer(bpage, tail, &ts, cpu_buffer->cpu, true);
         |         ^~~
         |         net
>> kernel/trace/ring_buffer.c:4046:48: warning: passing argument 3 of 'rb_read_data_buffer' makes integer from pointer without a cast [-Wint-conversion]
    4046 |         ret = rb_read_data_buffer(bpage, tail, &ts, cpu_buffer->cpu, true);
         |                                                ^~~
         |                                                |
         |                                                u64 * {aka long long unsigned int *}
   kernel/trace/ring_buffer.c:1642:78: note: expected 'int' but argument is of type 'u64 *' {aka 'long long unsigned int *'}
    1642 | static int rb_read_data_buffer(struct buffer_data_page *dpage, int tail, int cpu,
         |                                                                          ~~~~^~~
>> kernel/trace/ring_buffer.c:4046:63: warning: passing argument 4 of 'rb_read_data_buffer' makes pointer from integer without a cast [-Wint-conversion]
    4046 |         ret = rb_read_data_buffer(bpage, tail, &ts, cpu_buffer->cpu, true);
         |                                                     ~~~~~~~~~~^~~~~
         |                                                               |
         |                                                               int
   kernel/trace/ring_buffer.c:1643:52: note: expected 'long long unsigned int *' but argument is of type 'int'
    1643 |                                unsigned long long *timestamp, bool warn)
         |                                ~~~~~~~~~~~~~~~~~~~~^~~~~~~~~
>> kernel/trace/ring_buffer.c:4020:13: warning: unused variable 'e' [-Wunused-variable]
    4020 |         int e;
         |             ^
>> kernel/trace/ring_buffer.c:4018:17: warning: unused variable 'delta' [-Wunused-variable]
    4018 |         u64 ts, delta;
         |                 ^~~~~
>> kernel/trace/ring_buffer.c:4016:35: warning: unused variable 'event' [-Wunused-variable]
    4016 |         struct ring_buffer_event *event;
         |                                   ^~~~~
   cc1: some warnings being treated as errors


vim +/cpu_buffer +1629 kernel/trace/ring_buffer.c

  1621	
  1622	#define buffer_warn_return(fmt, ...)					\
  1623		do {								\
  1624			/* If another report is happening, ignore this one */	\
  1625			if (atomic_inc_return(&ts_dump) != 1) {			\
  1626				atomic_dec(&ts_dump);				\
  1627				goto out;					\
  1628			}							\
> 1629			atomic_inc(&cpu_buffer->record_disabled);		\
  1630			pr_warn(fmt, ##__VA_ARGS__);				\
> 1631			dump_buffer_page(bpage, info, tail);			\
  1632			atomic_dec(&ts_dump);					\
  1633			/* There's some cases in boot up that this can happen */ \
  1634			if (WARN_ON_ONCE(system_state != SYSTEM_BOOTING))	\
  1635				/* Do not re-enable checking */			\
> 1636				return;						\
  1637		} while (0)
  1638	#else
  1639	#define buffer_warn_return(fmt, ...) do { } while (0)
  1640	#endif
  1641	
  1642	static int rb_read_data_buffer(struct buffer_data_page *dpage, int tail, int cpu,
> 1643				       unsigned long long *timestamp, bool warn)
  1644	{
  1645		struct ring_buffer_event *event;
  1646		u64 ts, delta;
  1647		int events = 0;
  1648		int e;
  1649	
  1650		ts = dpage->time_stamp;
  1651	
  1652		for (e = 0; e < tail; e += rb_event_length(event)) {
  1653	
  1654			event = (struct ring_buffer_event *)(dpage->data + e);
  1655	
  1656			switch (event->type_len) {
  1657	
  1658			case RINGBUF_TYPE_TIME_EXTEND:
  1659				delta = rb_event_time_stamp(event);
  1660				ts += delta;
  1661				break;
  1662	
  1663			case RINGBUF_TYPE_TIME_STAMP:
  1664				delta = rb_event_time_stamp(event);
  1665				delta = rb_fix_abs_ts(delta, ts);
  1666				if (warn && delta < ts) {
> 1667					buffer_warn_return("[CPU: %d]ABSOLUTE TIME WENT BACKWARDS: last ts: %lld absolute ts: %lld\n",
  1668							   cpu, ts, delta);
  1669				}
  1670				ts = delta;
  1671				break;
  1672	
  1673			case RINGBUF_TYPE_PADDING:
  1674				if (event->time_delta == 1)
  1675					break;
  1676				fallthrough;
  1677			case RINGBUF_TYPE_DATA:
  1678				events++;
  1679				ts += event->time_delta;
  1680				break;
  1681	
  1682			default:
  1683				return -1;
  1684			}
  1685		}
  1686		*timestamp = ts;
  1687		return events;
  1688	}
  1689	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

