Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C66167E898D
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 07:38:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbjKKGiF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Nov 2023 01:38:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjKKGiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Nov 2023 01:38:04 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F5FE1BD;
        Fri, 10 Nov 2023 22:38:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699684680; x=1731220680;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=D+tGfvCQJ9V1xx3mrnTac1Wu9FAKjry3Gfbn3Hb4aTc=;
  b=Ahd0UHyZ5P2jpO60l/vX7gBKbqEG5rzfqrc6vkg4DlXPf2tAW+Soq/XJ
   taSb9OozByxFoYXvP1Mlzb6E4m1rYUqkcToAbNx+VruFFk5sBaXeg7MJs
   9t0uOf5OlMVttptNO3ruknvdzf712BWv6O5YB0sN0aNwcaP0xMLOwOSTr
   fdmEBDRuO3HhqJ+BAPe7DSCrPBL0TOIwa3V/sPRHT5nezs7/fiV1el3Zm
   zbBpXOLLrAsehM9/A6kFU9izjPVNoF5sgg4PRe9B0RUQ+7GBYouI41HGb
   +Ti7nORVlZ+CoikJEIeiwWug1w5a8hW/j7tcpz1iCfAOLiwxFCxz6s/+7
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10890"; a="370463648"
X-IronPort-AV: E=Sophos;i="6.03,294,1694761200"; 
   d="scan'208";a="370463648"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2023 22:37:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10890"; a="740312473"
X-IronPort-AV: E=Sophos;i="6.03,294,1694761200"; 
   d="scan'208";a="740312473"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 10 Nov 2023 22:37:55 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r1hcv-000AGk-0u;
        Sat, 11 Nov 2023 06:37:53 +0000
Date:   Sat, 11 Nov 2023 14:37:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bragatheswaran Manickavel <bragathemanick0908@gmail.com>,
        ralf@linux-mips.org, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Bragatheswaran Manickavel <bragathemanick0908@gmail.com>,
        linux-hams@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        syzbot+0145ea560de205bc09f0@syzkaller.appspotmail.com
Subject: Re: [PATCH] net: memory leak in nr_rx_frame
Message-ID: <202311111418.ojyVQuqO-lkp@intel.com>
References: <20231110173632.2511-1-bragathemanick0908@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231110173632.2511-1-bragathemanick0908@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bragatheswaran,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]
[also build test WARNING on net/main linus/master horms-ipvs/master v6.6 next-20231110]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Bragatheswaran-Manickavel/net-memory-leak-in-nr_rx_frame/20231111-013821
base:   net-next/main
patch link:    https://lore.kernel.org/r/20231110173632.2511-1-bragathemanick0908%40gmail.com
patch subject: [PATCH] net: memory leak in nr_rx_frame
config: powerpc64-allyesconfig (https://download.01.org/0day-ci/archive/20231111/202311111418.ojyVQuqO-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231111/202311111418.ojyVQuqO-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311111418.ojyVQuqO-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> net/netrom/af_netrom.c:968:6: warning: variable 'make' is used uninitialized whenever '||' condition is true [-Wsometimes-uninitialized]
     968 |         if (sk == NULL || sk_acceptq_is_full(sk) ||
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   net/netrom/af_netrom.c:973:7: note: uninitialized use occurs here
     973 |                 if (make)
         |                     ^~~~
   net/netrom/af_netrom.c:968:6: note: remove the '||' if its condition is always false
     968 |         if (sk == NULL || sk_acceptq_is_full(sk) ||
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> net/netrom/af_netrom.c:968:6: warning: variable 'make' is used uninitialized whenever '||' condition is true [-Wsometimes-uninitialized]
     968 |         if (sk == NULL || sk_acceptq_is_full(sk) ||
         |             ^~~~~~~~~~
   net/netrom/af_netrom.c:973:7: note: uninitialized use occurs here
     973 |                 if (make)
         |                     ^~~~
   net/netrom/af_netrom.c:968:6: note: remove the '||' if its condition is always false
     968 |         if (sk == NULL || sk_acceptq_is_full(sk) ||
         |             ^~~~~~~~~~~~~
   net/netrom/af_netrom.c:874:19: note: initialize the variable 'make' to silence this warning
     874 |         struct sock *make;
         |                          ^
         |                           = NULL
   2 warnings generated.


vim +968 net/netrom/af_netrom.c

^1da177e4c3f41 Linus Torvalds            2005-04-16   870  
^1da177e4c3f41 Linus Torvalds            2005-04-16   871  int nr_rx_frame(struct sk_buff *skb, struct net_device *dev)
^1da177e4c3f41 Linus Torvalds            2005-04-16   872  {
^1da177e4c3f41 Linus Torvalds            2005-04-16   873  	struct sock *sk;
^1da177e4c3f41 Linus Torvalds            2005-04-16   874  	struct sock *make;
^1da177e4c3f41 Linus Torvalds            2005-04-16   875  	struct nr_sock *nr_make;
^1da177e4c3f41 Linus Torvalds            2005-04-16   876  	ax25_address *src, *dest, *user;
^1da177e4c3f41 Linus Torvalds            2005-04-16   877  	unsigned short circuit_index, circuit_id;
^1da177e4c3f41 Linus Torvalds            2005-04-16   878  	unsigned short peer_circuit_index, peer_circuit_id;
^1da177e4c3f41 Linus Torvalds            2005-04-16   879  	unsigned short frametype, flags, window, timeout;
^1da177e4c3f41 Linus Torvalds            2005-04-16   880  	int ret;
^1da177e4c3f41 Linus Torvalds            2005-04-16   881  
c8c8218ec5af5d Cong Wang                 2019-06-27   882  	skb_orphan(skb);
^1da177e4c3f41 Linus Torvalds            2005-04-16   883  
^1da177e4c3f41 Linus Torvalds            2005-04-16   884  	/*
^1da177e4c3f41 Linus Torvalds            2005-04-16   885  	 *	skb->data points to the netrom frame start
^1da177e4c3f41 Linus Torvalds            2005-04-16   886  	 */
^1da177e4c3f41 Linus Torvalds            2005-04-16   887  
^1da177e4c3f41 Linus Torvalds            2005-04-16   888  	src  = (ax25_address *)(skb->data + 0);
^1da177e4c3f41 Linus Torvalds            2005-04-16   889  	dest = (ax25_address *)(skb->data + 7);
^1da177e4c3f41 Linus Torvalds            2005-04-16   890  
^1da177e4c3f41 Linus Torvalds            2005-04-16   891  	circuit_index      = skb->data[15];
^1da177e4c3f41 Linus Torvalds            2005-04-16   892  	circuit_id         = skb->data[16];
^1da177e4c3f41 Linus Torvalds            2005-04-16   893  	peer_circuit_index = skb->data[17];
^1da177e4c3f41 Linus Torvalds            2005-04-16   894  	peer_circuit_id    = skb->data[18];
^1da177e4c3f41 Linus Torvalds            2005-04-16   895  	frametype          = skb->data[19] & 0x0F;
^1da177e4c3f41 Linus Torvalds            2005-04-16   896  	flags              = skb->data[19] & 0xF0;
^1da177e4c3f41 Linus Torvalds            2005-04-16   897  
^1da177e4c3f41 Linus Torvalds            2005-04-16   898  	/*
^1da177e4c3f41 Linus Torvalds            2005-04-16   899  	 * Check for an incoming IP over NET/ROM frame.
^1da177e4c3f41 Linus Torvalds            2005-04-16   900  	 */
98a82febb63404 Ralf Baechle              2005-08-24   901  	if (frametype == NR_PROTOEXT &&
98a82febb63404 Ralf Baechle              2005-08-24   902  	    circuit_index == NR_PROTO_IP && circuit_id == NR_PROTO_IP) {
^1da177e4c3f41 Linus Torvalds            2005-04-16   903  		skb_pull(skb, NR_NETWORK_LEN + NR_TRANSPORT_LEN);
badff6d01a8589 Arnaldo Carvalho de Melo  2007-03-13   904  		skb_reset_transport_header(skb);
^1da177e4c3f41 Linus Torvalds            2005-04-16   905  
^1da177e4c3f41 Linus Torvalds            2005-04-16   906  		return nr_rx_ip(skb, dev);
^1da177e4c3f41 Linus Torvalds            2005-04-16   907  	}
^1da177e4c3f41 Linus Torvalds            2005-04-16   908  
^1da177e4c3f41 Linus Torvalds            2005-04-16   909  	/*
^1da177e4c3f41 Linus Torvalds            2005-04-16   910  	 * Find an existing socket connection, based on circuit ID, if it's
^1da177e4c3f41 Linus Torvalds            2005-04-16   911  	 * a Connect Request base it on their circuit ID.
^1da177e4c3f41 Linus Torvalds            2005-04-16   912  	 *
^1da177e4c3f41 Linus Torvalds            2005-04-16   913  	 * Circuit ID 0/0 is not valid but it could still be a "reset" for a
^1da177e4c3f41 Linus Torvalds            2005-04-16   914  	 * circuit that no longer exists at the other end ...
^1da177e4c3f41 Linus Torvalds            2005-04-16   915  	 */
^1da177e4c3f41 Linus Torvalds            2005-04-16   916  
^1da177e4c3f41 Linus Torvalds            2005-04-16   917  	sk = NULL;
^1da177e4c3f41 Linus Torvalds            2005-04-16   918  
^1da177e4c3f41 Linus Torvalds            2005-04-16   919  	if (circuit_index == 0 && circuit_id == 0) {
^1da177e4c3f41 Linus Torvalds            2005-04-16   920  		if (frametype == NR_CONNACK && flags == NR_CHOKE_FLAG)
^1da177e4c3f41 Linus Torvalds            2005-04-16   921  			sk = nr_find_peer(peer_circuit_index, peer_circuit_id, src);
^1da177e4c3f41 Linus Torvalds            2005-04-16   922  	} else {
^1da177e4c3f41 Linus Torvalds            2005-04-16   923  		if (frametype == NR_CONNREQ)
^1da177e4c3f41 Linus Torvalds            2005-04-16   924  			sk = nr_find_peer(circuit_index, circuit_id, src);
^1da177e4c3f41 Linus Torvalds            2005-04-16   925  		else
^1da177e4c3f41 Linus Torvalds            2005-04-16   926  			sk = nr_find_socket(circuit_index, circuit_id);
^1da177e4c3f41 Linus Torvalds            2005-04-16   927  	}
^1da177e4c3f41 Linus Torvalds            2005-04-16   928  
^1da177e4c3f41 Linus Torvalds            2005-04-16   929  	if (sk != NULL) {
7314f5480f3e37 Cong Wang                 2018-12-29   930  		bh_lock_sock(sk);
badff6d01a8589 Arnaldo Carvalho de Melo  2007-03-13   931  		skb_reset_transport_header(skb);
^1da177e4c3f41 Linus Torvalds            2005-04-16   932  
^1da177e4c3f41 Linus Torvalds            2005-04-16   933  		if (frametype == NR_CONNACK && skb->len == 22)
^1da177e4c3f41 Linus Torvalds            2005-04-16   934  			nr_sk(sk)->bpqext = 1;
^1da177e4c3f41 Linus Torvalds            2005-04-16   935  		else
^1da177e4c3f41 Linus Torvalds            2005-04-16   936  			nr_sk(sk)->bpqext = 0;
^1da177e4c3f41 Linus Torvalds            2005-04-16   937  
^1da177e4c3f41 Linus Torvalds            2005-04-16   938  		ret = nr_process_rx_frame(sk, skb);
^1da177e4c3f41 Linus Torvalds            2005-04-16   939  		bh_unlock_sock(sk);
7314f5480f3e37 Cong Wang                 2018-12-29   940  		sock_put(sk);
^1da177e4c3f41 Linus Torvalds            2005-04-16   941  		return ret;
^1da177e4c3f41 Linus Torvalds            2005-04-16   942  	}
^1da177e4c3f41 Linus Torvalds            2005-04-16   943  
^1da177e4c3f41 Linus Torvalds            2005-04-16   944  	/*
^1da177e4c3f41 Linus Torvalds            2005-04-16   945  	 * Now it should be a CONNREQ.
^1da177e4c3f41 Linus Torvalds            2005-04-16   946  	 */
^1da177e4c3f41 Linus Torvalds            2005-04-16   947  	if (frametype != NR_CONNREQ) {
^1da177e4c3f41 Linus Torvalds            2005-04-16   948  		/*
^1da177e4c3f41 Linus Torvalds            2005-04-16   949  		 * Here it would be nice to be able to send a reset but
e21ce8c7c013fb Ralf Baechle              2005-09-12   950  		 * NET/ROM doesn't have one.  We've tried to extend the protocol
e21ce8c7c013fb Ralf Baechle              2005-09-12   951  		 * by sending NR_CONNACK | NR_CHOKE_FLAGS replies but that
e21ce8c7c013fb Ralf Baechle              2005-09-12   952  		 * apparently kills BPQ boxes... :-(
e21ce8c7c013fb Ralf Baechle              2005-09-12   953  		 * So now we try to follow the established behaviour of
e21ce8c7c013fb Ralf Baechle              2005-09-12   954  		 * G8PZT's Xrouter which is sending packets with command type 7
e21ce8c7c013fb Ralf Baechle              2005-09-12   955  		 * as an extension of the protocol.
^1da177e4c3f41 Linus Torvalds            2005-04-16   956  		 */
e21ce8c7c013fb Ralf Baechle              2005-09-12   957  		if (sysctl_netrom_reset_circuit &&
e21ce8c7c013fb Ralf Baechle              2005-09-12   958  		    (frametype != NR_RESET || flags != 0))
e21ce8c7c013fb Ralf Baechle              2005-09-12   959  			nr_transmit_reset(skb, 1);
e21ce8c7c013fb Ralf Baechle              2005-09-12   960  
^1da177e4c3f41 Linus Torvalds            2005-04-16   961  		return 0;
^1da177e4c3f41 Linus Torvalds            2005-04-16   962  	}
^1da177e4c3f41 Linus Torvalds            2005-04-16   963  
^1da177e4c3f41 Linus Torvalds            2005-04-16   964  	sk = nr_find_listener(dest);
^1da177e4c3f41 Linus Torvalds            2005-04-16   965  
^1da177e4c3f41 Linus Torvalds            2005-04-16   966  	user = (ax25_address *)(skb->data + 21);
^1da177e4c3f41 Linus Torvalds            2005-04-16   967  
^1da177e4c3f41 Linus Torvalds            2005-04-16  @968  	if (sk == NULL || sk_acceptq_is_full(sk) ||
^1da177e4c3f41 Linus Torvalds            2005-04-16   969  	    (make = nr_make_new(sk)) == NULL) {
^1da177e4c3f41 Linus Torvalds            2005-04-16   970  		nr_transmit_refusal(skb, 0);
^1da177e4c3f41 Linus Torvalds            2005-04-16   971  		if (sk)
7314f5480f3e37 Cong Wang                 2018-12-29   972  			sock_put(sk);
d05be0015c62fa Bragatheswaran Manickavel 2023-11-10   973  		if (make)
d05be0015c62fa Bragatheswaran Manickavel 2023-11-10   974  			sock_put(make);
^1da177e4c3f41 Linus Torvalds            2005-04-16   975  		return 0;
^1da177e4c3f41 Linus Torvalds            2005-04-16   976  	}
^1da177e4c3f41 Linus Torvalds            2005-04-16   977  
7314f5480f3e37 Cong Wang                 2018-12-29   978  	bh_lock_sock(sk);
7314f5480f3e37 Cong Wang                 2018-12-29   979  
^1da177e4c3f41 Linus Torvalds            2005-04-16   980  	window = skb->data[20];
^1da177e4c3f41 Linus Torvalds            2005-04-16   981  
4638faac032756 Cong Wang                 2019-07-22   982  	sock_hold(make);
^1da177e4c3f41 Linus Torvalds            2005-04-16   983  	skb->sk             = make;
c8c8218ec5af5d Cong Wang                 2019-06-27   984  	skb->destructor     = sock_efree;
^1da177e4c3f41 Linus Torvalds            2005-04-16   985  	make->sk_state	    = TCP_ESTABLISHED;
^1da177e4c3f41 Linus Torvalds            2005-04-16   986  
^1da177e4c3f41 Linus Torvalds            2005-04-16   987  	/* Fill in his circuit details */
^1da177e4c3f41 Linus Torvalds            2005-04-16   988  	nr_make = nr_sk(make);
^1da177e4c3f41 Linus Torvalds            2005-04-16   989  	nr_make->source_addr = *dest;
^1da177e4c3f41 Linus Torvalds            2005-04-16   990  	nr_make->dest_addr   = *src;
^1da177e4c3f41 Linus Torvalds            2005-04-16   991  	nr_make->user_addr   = *user;
^1da177e4c3f41 Linus Torvalds            2005-04-16   992  
^1da177e4c3f41 Linus Torvalds            2005-04-16   993  	nr_make->your_index  = circuit_index;
^1da177e4c3f41 Linus Torvalds            2005-04-16   994  	nr_make->your_id     = circuit_id;
^1da177e4c3f41 Linus Torvalds            2005-04-16   995  
^1da177e4c3f41 Linus Torvalds            2005-04-16   996  	bh_unlock_sock(sk);
^1da177e4c3f41 Linus Torvalds            2005-04-16   997  	circuit = nr_find_next_circuit();
^1da177e4c3f41 Linus Torvalds            2005-04-16   998  	bh_lock_sock(sk);
^1da177e4c3f41 Linus Torvalds            2005-04-16   999  
^1da177e4c3f41 Linus Torvalds            2005-04-16  1000  	nr_make->my_index    = circuit / 256;
^1da177e4c3f41 Linus Torvalds            2005-04-16  1001  	nr_make->my_id       = circuit % 256;
^1da177e4c3f41 Linus Torvalds            2005-04-16  1002  
^1da177e4c3f41 Linus Torvalds            2005-04-16  1003  	circuit++;
^1da177e4c3f41 Linus Torvalds            2005-04-16  1004  
^1da177e4c3f41 Linus Torvalds            2005-04-16  1005  	/* Window negotiation */
^1da177e4c3f41 Linus Torvalds            2005-04-16  1006  	if (window < nr_make->window)
^1da177e4c3f41 Linus Torvalds            2005-04-16  1007  		nr_make->window = window;
^1da177e4c3f41 Linus Torvalds            2005-04-16  1008  
^1da177e4c3f41 Linus Torvalds            2005-04-16  1009  	/* L4 timeout negotiation */
^1da177e4c3f41 Linus Torvalds            2005-04-16  1010  	if (skb->len == 37) {
^1da177e4c3f41 Linus Torvalds            2005-04-16  1011  		timeout = skb->data[36] * 256 + skb->data[35];
^1da177e4c3f41 Linus Torvalds            2005-04-16  1012  		if (timeout * HZ < nr_make->t1)
^1da177e4c3f41 Linus Torvalds            2005-04-16  1013  			nr_make->t1 = timeout * HZ;
^1da177e4c3f41 Linus Torvalds            2005-04-16  1014  		nr_make->bpqext = 1;
^1da177e4c3f41 Linus Torvalds            2005-04-16  1015  	} else {
^1da177e4c3f41 Linus Torvalds            2005-04-16  1016  		nr_make->bpqext = 0;
^1da177e4c3f41 Linus Torvalds            2005-04-16  1017  	}
^1da177e4c3f41 Linus Torvalds            2005-04-16  1018  
^1da177e4c3f41 Linus Torvalds            2005-04-16  1019  	nr_write_internal(make, NR_CONNACK);
^1da177e4c3f41 Linus Torvalds            2005-04-16  1020  
^1da177e4c3f41 Linus Torvalds            2005-04-16  1021  	nr_make->condition = 0x00;
^1da177e4c3f41 Linus Torvalds            2005-04-16  1022  	nr_make->vs        = 0;
^1da177e4c3f41 Linus Torvalds            2005-04-16  1023  	nr_make->va        = 0;
^1da177e4c3f41 Linus Torvalds            2005-04-16  1024  	nr_make->vr        = 0;
^1da177e4c3f41 Linus Torvalds            2005-04-16  1025  	nr_make->vl        = 0;
^1da177e4c3f41 Linus Torvalds            2005-04-16  1026  	nr_make->state     = NR_STATE_3;
18601a7d30c834 Ralf Baechle              2006-07-03  1027  	sk_acceptq_added(sk);
^1da177e4c3f41 Linus Torvalds            2005-04-16  1028  	skb_queue_head(&sk->sk_receive_queue, skb);
^1da177e4c3f41 Linus Torvalds            2005-04-16  1029  
^1da177e4c3f41 Linus Torvalds            2005-04-16  1030  	if (!sock_flag(sk, SOCK_DEAD))
676d23690fb62b David S. Miller           2014-04-11  1031  		sk->sk_data_ready(sk);
^1da177e4c3f41 Linus Torvalds            2005-04-16  1032  
^1da177e4c3f41 Linus Torvalds            2005-04-16  1033  	bh_unlock_sock(sk);
7314f5480f3e37 Cong Wang                 2018-12-29  1034  	sock_put(sk);
5cc29e3bea7709 Ralf Baechle              2006-07-10  1035  
5cc29e3bea7709 Ralf Baechle              2006-07-10  1036  	nr_insert_socket(make);
5cc29e3bea7709 Ralf Baechle              2006-07-10  1037  
5cc29e3bea7709 Ralf Baechle              2006-07-10  1038  	nr_start_heartbeat(make);
5cc29e3bea7709 Ralf Baechle              2006-07-10  1039  	nr_start_idletimer(make);
5cc29e3bea7709 Ralf Baechle              2006-07-10  1040  
^1da177e4c3f41 Linus Torvalds            2005-04-16  1041  	return 1;
^1da177e4c3f41 Linus Torvalds            2005-04-16  1042  }
^1da177e4c3f41 Linus Torvalds            2005-04-16  1043  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
