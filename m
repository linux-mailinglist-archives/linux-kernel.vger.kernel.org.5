Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22EE47D5AD6
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 20:44:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344160AbjJXSo2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 14:44:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344042AbjJXSo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 14:44:26 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65571186;
        Tue, 24 Oct 2023 11:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698173064; x=1729709064;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0agB9+eKx+cq1VNd6N/1YyY/E3g2/msA0IL4s2WLDmQ=;
  b=SnBVglyk0wFS6dpr3AvU/0hJJdOSqyceEZxeAky/n2xBHgUCtiUxA6Dz
   TxrEAE5pKO0VQwwK79kjXH1sn32ajhSD+0QSkv6P8U/vipLPZ900uWKDN
   jptiGFkpNK+8ryQT8yUK4dbufCLAPFn2xF658zruY4868QJKEaRDPdIbV
   UwuGq+7oZNV+npZr3nDqu0p20CnDB5YkpNcDlcz+ZT41jdSCX5q3U8Psa
   3pBZUx25b0lPYBWbxnx2vjHmeAG4ZJdBuTBB6j4hJtI3xyRNmT7/aM1yE
   FW5Q14TgoL9iD1+VMx9hEHNB2XAvVUTAirFeGX1xp7uLl4YoIE5tVspvS
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="389993647"
X-IronPort-AV: E=Sophos;i="6.03,248,1694761200"; 
   d="scan'208";a="389993647"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 11:44:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,248,1694761200"; 
   d="scan'208";a="6558968"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 24 Oct 2023 11:44:12 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qvMO0-0008AF-2R;
        Tue, 24 Oct 2023 18:44:16 +0000
Date:   Wed, 25 Oct 2023 02:43:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Daniel =?iso-8859-1?Q?Gr=F6ber?= <dxld@darkboxed.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, wireguard@lists.zx2c4.com,
        linux-kernel@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
        Daniel =?iso-8859-1?Q?Gr=F6ber?= <dxld@darkboxed.org>
Subject: Re: [PATCH] wireguard: Add netlink attrs for binding to address and
 netdev
Message-ID: <202310250256.kXWoLwJm-lkp@intel.com>
References: <20231023160006.85992-1-dxld@darkboxed.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231023160006.85992-1-dxld@darkboxed.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.6-rc7 next-20231024]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Daniel-Gr-ber/wireguard-Add-netlink-attrs-for-binding-to-address-and-netdev/20231024-000158
base:   linus/master
patch link:    https://lore.kernel.org/r/20231023160006.85992-1-dxld%40darkboxed.org
patch subject: [PATCH] wireguard: Add netlink attrs for binding to address and netdev
config: um-randconfig-002-20231024 (https://download.01.org/0day-ci/archive/20231025/202310250256.kXWoLwJm-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231025/202310250256.kXWoLwJm-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310250256.kXWoLwJm-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/net/wireguard/netlink.c: In function 'wg_get_device_dump':
>> drivers/net/wireguard/netlink.c:247:52: error: 'struct udp_port_cfg' has no member named 'local_ip6'; did you mean 'local_ip'?
     247 |                                      &wg->port_cfg.local_ip6))
         |                                                    ^~~~~~~~~
         |                                                    local_ip
   drivers/net/wireguard/netlink.c: In function 'set_port_cfg':
   drivers/net/wireguard/netlink.c:348:34: error: 'struct udp_port_cfg' has no member named 'local_ip6'; did you mean 'local_ip'?
     348 |                         port_cfg.local_ip6 = u_addr->addr6;
         |                                  ^~~~~~~~~
         |                                  local_ip


vim +247 drivers/net/wireguard/netlink.c

   211	
   212	static int wg_get_device_dump(struct sk_buff *skb, struct netlink_callback *cb)
   213	{
   214		struct wg_peer *peer, *next_peer_cursor;
   215		struct dump_ctx *ctx = DUMP_CTX(cb);
   216		struct wg_device *wg = ctx->wg;
   217		struct nlattr *peers_nest;
   218		int ret = -EMSGSIZE;
   219		bool done = true;
   220		void *hdr;
   221	
   222		rtnl_lock();
   223		mutex_lock(&wg->device_update_lock);
   224		cb->seq = wg->device_update_gen;
   225		next_peer_cursor = ctx->next_peer;
   226	
   227		hdr = genlmsg_put(skb, NETLINK_CB(cb->skb).portid, cb->nlh->nlmsg_seq,
   228				  &genl_family, NLM_F_MULTI, WG_CMD_GET_DEVICE);
   229		if (!hdr)
   230			goto out;
   231		genl_dump_check_consistent(cb, hdr);
   232	
   233		if (!ctx->next_peer) {
   234			if (nla_put_u16(skb, WGDEVICE_A_LISTEN_PORT,
   235					ntohs(wg->port_cfg.local_udp_port)) ||
   236			    nla_put_u32(skb, WGDEVICE_A_LISTEN_IFINDEX, wg->port_cfg.bind_ifindex) ||
   237			    nla_put_u32(skb, WGDEVICE_A_FWMARK, wg->fwmark) ||
   238			    nla_put_u32(skb, WGDEVICE_A_IFINDEX, wg->dev->ifindex) ||
   239			    nla_put_string(skb, WGDEVICE_A_IFNAME, wg->dev->name))
   240				goto out;
   241		        if (wg->port_cfg.family == AF_INET &&
   242			    nla_put_in_addr(skb, WGDEVICE_A_LISTEN_ADDR,
   243					    wg->port_cfg.local_ip.s_addr))
   244					goto out;
   245		        if (wg->port_cfg.family == AF_INET6 &&
   246			    nla_put_in6_addr(skb, WGDEVICE_A_LISTEN_ADDR,
 > 247					     &wg->port_cfg.local_ip6))
   248					goto out;
   249	
   250			down_read(&wg->static_identity.lock);
   251			if (wg->static_identity.has_identity) {
   252				if (nla_put(skb, WGDEVICE_A_PRIVATE_KEY,
   253					    NOISE_PUBLIC_KEY_LEN,
   254					    wg->static_identity.static_private) ||
   255				    nla_put(skb, WGDEVICE_A_PUBLIC_KEY,
   256					    NOISE_PUBLIC_KEY_LEN,
   257					    wg->static_identity.static_public)) {
   258					up_read(&wg->static_identity.lock);
   259					goto out;
   260				}
   261			}
   262			up_read(&wg->static_identity.lock);
   263		}
   264	
   265		peers_nest = nla_nest_start(skb, WGDEVICE_A_PEERS);
   266		if (!peers_nest)
   267			goto out;
   268		ret = 0;
   269		/* If the last cursor was removed via list_del_init in peer_remove, then
   270		 * we just treat this the same as there being no more peers left. The
   271		 * reason is that seq_nr should indicate to userspace that this isn't a
   272		 * coherent dump anyway, so they'll try again.
   273		 */
   274		if (list_empty(&wg->peer_list) ||
   275		    (ctx->next_peer && list_empty(&ctx->next_peer->peer_list))) {
   276			nla_nest_cancel(skb, peers_nest);
   277			goto out;
   278		}
   279		lockdep_assert_held(&wg->device_update_lock);
   280		peer = list_prepare_entry(ctx->next_peer, &wg->peer_list, peer_list);
   281		list_for_each_entry_continue(peer, &wg->peer_list, peer_list) {
   282			if (get_peer(peer, skb, ctx)) {
   283				done = false;
   284				break;
   285			}
   286			next_peer_cursor = peer;
   287		}
   288		nla_nest_end(skb, peers_nest);
   289	
   290	out:
   291		if (!ret && !done && next_peer_cursor)
   292			wg_peer_get(next_peer_cursor);
   293		wg_peer_put(ctx->next_peer);
   294		mutex_unlock(&wg->device_update_lock);
   295		rtnl_unlock();
   296	
   297		if (ret) {
   298			genlmsg_cancel(skb, hdr);
   299			return ret;
   300		}
   301		genlmsg_end(skb, hdr);
   302		if (done) {
   303			ctx->next_peer = NULL;
   304			return 0;
   305		}
   306		ctx->next_peer = next_peer_cursor;
   307		return skb->len;
   308	
   309		/* At this point, we can't really deal ourselves with safely zeroing out
   310		 * the private key material after usage. This will need an additional API
   311		 * in the kernel for marking skbs as zero_on_free.
   312		 */
   313	}
   314	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
