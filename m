Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A144789280
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 01:45:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbjHYXo6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 19:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjHYXob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 19:44:31 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06DB3173F;
        Fri, 25 Aug 2023 16:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693007069; x=1724543069;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=a93CQNideEpCac1GKyqO1h/vQ94p6vVNP2zLtDvDUuU=;
  b=mponNT6D7Fj0oXFQoYrRddUm07R1QFxWfwujNIrRjcXTmaxJ2OfPd5kY
   U9T1WSYTjvoNQyF0KLxdV9vZ7/ZmHzvyO5YIBg8m+qJleN+E/Gssd5RMn
   0DvvRVU2cBbXLYVkWBCy1yboh7Bb+DeAwz4s0a8GAs2u7oq5wN43KXn1B
   CyzK//DWDZXeZn6ZjwDzuoyLbAWF1cO8SUFuObYhTqfuaK3VWDgetKBr8
   ChnJzNOcdxqFP318Pdk9bMv/nZhn2CgLfPbnrk+xmQPEMgjoVQZPAvVow
   Jk/1dCP/8jUpcN6WEVM9tEOei1fo5j5ta6D5Sdwn31CPbRi2K0o+kdN3F
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10813"; a="365027613"
X-IronPort-AV: E=Sophos;i="6.02,202,1688454000"; 
   d="scan'208";a="365027613"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2023 16:44:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10813"; a="772657878"
X-IronPort-AV: E=Sophos;i="6.02,202,1688454000"; 
   d="scan'208";a="772657878"
Received: from lkp-server02.sh.intel.com (HELO daf8bb0a381d) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 25 Aug 2023 16:44:24 -0700
Received: from kbuild by daf8bb0a381d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qZgTX-00048B-1F;
        Fri, 25 Aug 2023 23:44:23 +0000
Date:   Sat, 26 Aug 2023 07:44:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Lukasz Majewski <lukma@denx.de>, Tristram.Ha@microchip.com,
        Eric Dumazet <edumazet@google.com>, davem@davemloft.net
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Paolo Abeni <pabeni@redhat.com>,
        Kristian Overskeid <koverskeid@gmail.com>,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukasz Majewski <lukma@denx.de>
Subject: Re: [PATCH] net: hsr : Provide fix for HSRv1 supervisor frames
 decoding
Message-ID: <202308260733.G7tU8UHx-lkp@intel.com>
References: <20230825153111.228768-1-lukma@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230825153111.228768-1-lukma@denx.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lukasz,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]
[also build test ERROR on net/main linus/master v6.5-rc7 next-20230825]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Lukasz-Majewski/net-hsr-Provide-fix-for-HSRv1-supervisor-frames-decoding/20230825-233423
base:   net-next/main
patch link:    https://lore.kernel.org/r/20230825153111.228768-1-lukma%40denx.de
patch subject: [PATCH] net: hsr : Provide fix for HSRv1 supervisor frames decoding
config: powerpc64-randconfig-r022-20230826 (https://download.01.org/0day-ci/archive/20230826/202308260733.G7tU8UHx-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce: (https://download.01.org/0day-ci/archive/20230826/202308260733.G7tU8UHx-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308260733.G7tU8UHx-lkp@intel.com/

All errors (new ones prefixed by >>):

>> net/hsr/hsr_framereg.c:289:8: error: expected ';' after expression
     289 |          * And leave the HSR tag.
         |               ^
         |               ;
>> net/hsr/hsr_framereg.c:289:5: error: use of undeclared identifier 'And'
     289 |          * And leave the HSR tag.
         |            ^
>> net/hsr/hsr_framereg.c:289:9: error: use of undeclared identifier 'leave'
     289 |          * And leave the HSR tag.
         |                ^
   3 errors generated.


vim +289 net/hsr/hsr_framereg.c

   249	
   250	/* Use the Supervision frame's info about an eventual macaddress_B for merging
   251	 * nodes that has previously had their macaddress_B registered as a separate
   252	 * node.
   253	 */
   254	void hsr_handle_sup_frame(struct hsr_frame_info *frame)
   255	{
   256		struct hsr_node *node_curr = frame->node_src;
   257		struct hsr_port *port_rcv = frame->port_rcv;
   258		struct hsr_priv *hsr = port_rcv->hsr;
   259		struct hsr_sup_payload *hsr_sp;
   260		struct hsr_sup_tlv *hsr_sup_tlv;
   261		struct hsr_node *node_real;
   262		struct sk_buff *skb = NULL;
   263		struct list_head *node_db;
   264		struct ethhdr *ethhdr;
   265		int i;
   266		unsigned int pull_size = 0;
   267		unsigned int total_pull_size = 0;
   268	
   269		/* Here either frame->skb_hsr or frame->skb_prp should be
   270		 * valid as supervision frame always will have protocol
   271		 * header info.
   272		 */
   273		if (frame->skb_hsr)
   274			skb = frame->skb_hsr;
   275		else if (frame->skb_prp)
   276			skb = frame->skb_prp;
   277		else if (frame->skb_std)
   278			skb = frame->skb_std;
   279		if (!skb)
   280			return;
   281	
   282		/* Leave the ethernet header. */
   283		pull_size = sizeof(struct ethhdr);
   284		skb_pull(skb, pull_size);
   285		total_pull_size += pull_size;
   286	
   287		ethhdr = (struct ethhdr *)skb_mac_header(skb);
   288	
 > 289		 * And leave the HSR tag.
   290		 *
   291		 * The HSRv1 supervisory frame encapsulates the v0 frame
   292		 * with EtherType of 0x88FB
   293		 */
   294		if (ethhdr->h_proto == htons(ETH_P_HSR)) {
   295			if (hsr->prot_version == HSR_V1)
   296				/* In the above step the DA, SA and EtherType
   297				 * (0x892F - HSRv1) bytes has been removed.
   298				 *
   299				 * As the HSRv1 has the HSR header added, one need
   300				 * to remove path_and_LSDU_size and sequence_nr fields.
   301				 *
   302				 */
   303				pull_size = 4;
   304			else
   305				pull_size = sizeof(struct hsr_tag);
   306	
   307			skb_pull(skb, pull_size);
   308			total_pull_size += pull_size;
   309		}
   310	
   311		/* And leave the HSR sup tag. */
   312		pull_size = sizeof(struct hsr_tag);
   313		skb_pull(skb, pull_size);
   314		total_pull_size += pull_size;
   315	
   316		/* get HSR sup payload */
   317		if (hsr->prot_version == HSR_V1) {
   318			/* In the HSRv1 supervisor frame, when
   319			 * one with EtherType = 0x88FB is extracted, the Node A
   320			 * MAC address is preceded with type and length elements of TLV
   321			 * data field.
   322			 *
   323			 * It needs to be removed to get the remote peer MAC address.
   324			 */
   325			pull_size = sizeof(struct hsr_sup_tlv);
   326			skb_pull(skb, pull_size);
   327			total_pull_size += pull_size;
   328		}
   329	
   330		hsr_sp = (struct hsr_sup_payload *)skb->data;
   331	
   332		/* Merge node_curr (registered on macaddress_B) into node_real */
   333		node_db = &port_rcv->hsr->node_db;
   334		node_real = find_node_by_addr_A(node_db, hsr_sp->macaddress_A);
   335		if (!node_real)
   336			/* No frame received from AddrA of this node yet */
   337			node_real = hsr_add_node(hsr, node_db, hsr_sp->macaddress_A,
   338						 HSR_SEQNR_START - 1, true,
   339						 port_rcv->type);
   340		if (!node_real)
   341			goto done; /* No mem */
   342		if (node_real == node_curr)
   343			/* Node has already been merged */
   344			goto done;
   345	
   346		/* Leave the first HSR sup payload. */
   347		pull_size = sizeof(struct hsr_sup_payload);
   348		skb_pull(skb, pull_size);
   349		total_pull_size += pull_size;
   350	
   351		/* Get second supervision tlv */
   352		hsr_sup_tlv = (struct hsr_sup_tlv *)skb->data;
   353		/* And check if it is a redbox mac TLV */
   354		if (hsr_sup_tlv->HSR_TLV_type == PRP_TLV_REDBOX_MAC) {
   355			/* We could stop here after pushing hsr_sup_payload,
   356			 * or proceed and allow macaddress_B and for redboxes.
   357			 */
   358			/* Sanity check length */
   359			if (hsr_sup_tlv->HSR_TLV_length != 6)
   360				goto done;
   361	
   362			/* Leave the second HSR sup tlv. */
   363			pull_size = sizeof(struct hsr_sup_tlv);
   364			skb_pull(skb, pull_size);
   365			total_pull_size += pull_size;
   366	
   367			/* Get redbox mac address. */
   368			hsr_sp = (struct hsr_sup_payload *)skb->data;
   369	
   370			/* Check if redbox mac and node mac are equal. */
   371			if (!ether_addr_equal(node_real->macaddress_A, hsr_sp->macaddress_A)) {
   372				/* This is a redbox supervision frame for a VDAN! */
   373				goto done;
   374			}
   375		}
   376	
   377		ether_addr_copy(node_real->macaddress_B, ethhdr->h_source);
   378		spin_lock_bh(&node_real->seq_out_lock);
   379		for (i = 0; i < HSR_PT_PORTS; i++) {
   380			if (!node_curr->time_in_stale[i] &&
   381			    time_after(node_curr->time_in[i], node_real->time_in[i])) {
   382				node_real->time_in[i] = node_curr->time_in[i];
   383				node_real->time_in_stale[i] =
   384							node_curr->time_in_stale[i];
   385			}
   386			if (seq_nr_after(node_curr->seq_out[i], node_real->seq_out[i]))
   387				node_real->seq_out[i] = node_curr->seq_out[i];
   388		}
   389		spin_unlock_bh(&node_real->seq_out_lock);
   390		node_real->addr_B_port = port_rcv->type;
   391	
   392		spin_lock_bh(&hsr->list_lock);
   393		if (!node_curr->removed) {
   394			list_del_rcu(&node_curr->mac_list);
   395			node_curr->removed = true;
   396			kfree_rcu(node_curr, rcu_head);
   397		}
   398		spin_unlock_bh(&hsr->list_lock);
   399	
   400	done:
   401		/* Push back here */
   402		skb_push(skb, total_pull_size);
   403	}
   404	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
