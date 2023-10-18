Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB08E7CDD04
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 15:17:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231374AbjJRNRA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 09:17:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231472AbjJRNQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 09:16:57 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79BA2109
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 06:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697635015; x=1729171015;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jeOFtHCTI1p4lK5pWUWJCbF1FQqSM44h4JC6UZC9JqQ=;
  b=ZtEO98I4Z4xYX30ecJxCXxk9A2jc5BynvaXIPDWuNo0RxezEd6q5tYSl
   a157HTqf+m4J4dYqGy6sUS9oZEHw0E5u7UTbVeXYH9nh4NhvKe+mFXyN6
   8+duQ4tnuMOQwR846D36v4kLvOhC03zMDRzZfkKNp9gXuEn2XWNYYnFkx
   NKepQleTURhW7TiJiUhsYXqND1/MrBJzwngQXEcUiscEZ7HkgiEZQQ/nF
   D0jFeDkSsnzPfcE6Fa7jU0HyssRtThBPBcU6rE8vWM6z2DO4z40pLmBaV
   KZ3Eq2Jc8Vm5OJ7iAN/RyHdatrwkISgl1xOymsEsHjLESSAz7nUTc36yE
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="450233218"
X-IronPort-AV: E=Sophos;i="6.03,235,1694761200"; 
   d="scan'208";a="450233218"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 06:16:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="756587511"
X-IronPort-AV: E=Sophos;i="6.03,235,1694761200"; 
   d="scan'208";a="756587511"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 18 Oct 2023 06:16:51 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qt6Po-0000Oh-1k;
        Wed, 18 Oct 2023 13:16:48 +0000
Date:   Wed, 18 Oct 2023 21:16:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Matias Ezequiel Vara Larsen <mvaralar@redhat.com>,
        anton.yakovlev@opensynergy.com, mst@redhat.com
Cc:     oe-kbuild-all@lists.linux.dev, mvaralar@redhat.com, perex@perex.cz,
        tiwai@suse.com, virtualization@lists.linux-foundation.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        pbonzini@redhat.com, stefanha@redhat.com, sgarzare@redhat.com,
        manos.pitsidianakis@linaro.org, mripard@redhat.com
Subject: Re: [PATCH v2] ALSA: virtio: use copy and fill_silence callbacks
Message-ID: <202310182118.4uWJrE2p-lkp@intel.com>
References: <ZS+392ZzVIoEyv8n@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZS+392ZzVIoEyv8n@fedora>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matias,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 8a749fd1a8720d4619c91c8b6e7528c0a355c0aa]

url:    https://github.com/intel-lab-lkp/linux/commits/Matias-Ezequiel-Vara-Larsen/ALSA-virtio-use-copy-and-fill_silence-callbacks/20231018-185108
base:   8a749fd1a8720d4619c91c8b6e7528c0a355c0aa
patch link:    https://lore.kernel.org/r/ZS%2B392ZzVIoEyv8n%40fedora
patch subject: [PATCH v2] ALSA: virtio: use copy and fill_silence callbacks
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20231018/202310182118.4uWJrE2p-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231018/202310182118.4uWJrE2p-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310182118.4uWJrE2p-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> sound/virtio/virtio_pcm_msg.c:200: warning: Function parameter or member 'offset' not described in 'virtsnd_pcm_msg_send'
>> sound/virtio/virtio_pcm_msg.c:200: warning: Function parameter or member 'bytes' not described in 'virtsnd_pcm_msg_send'
   2 warnings as Errors


vim +200 sound/virtio/virtio_pcm_msg.c

f40a28679e0b7c Anton Yakovlev              2021-03-02  184  
f40a28679e0b7c Anton Yakovlev              2021-03-02  185  /**
f40a28679e0b7c Anton Yakovlev              2021-03-02  186   * virtsnd_pcm_msg_send() - Send asynchronous I/O messages.
f40a28679e0b7c Anton Yakovlev              2021-03-02  187   * @vss: VirtIO PCM substream.
f40a28679e0b7c Anton Yakovlev              2021-03-02  188   *
f40a28679e0b7c Anton Yakovlev              2021-03-02  189   * All messages are organized in an ordered circular list. Each time the
f40a28679e0b7c Anton Yakovlev              2021-03-02  190   * function is called, all currently non-enqueued messages are added to the
10ad52116c3a46 Matias Ezequiel Vara Larsen 2023-10-18  191   * virtqueue. For this, the function uses offset and bytes to calculate the
10ad52116c3a46 Matias Ezequiel Vara Larsen 2023-10-18  192   * messages that need to be added.
f40a28679e0b7c Anton Yakovlev              2021-03-02  193   *
f40a28679e0b7c Anton Yakovlev              2021-03-02  194   * Context: Any context. Expects the tx/rx queue and the VirtIO substream
f40a28679e0b7c Anton Yakovlev              2021-03-02  195   *          spinlocks to be held by caller.
f40a28679e0b7c Anton Yakovlev              2021-03-02  196   * Return: 0 on success, -errno on failure.
f40a28679e0b7c Anton Yakovlev              2021-03-02  197   */
10ad52116c3a46 Matias Ezequiel Vara Larsen 2023-10-18  198  int virtsnd_pcm_msg_send(struct virtio_pcm_substream *vss, unsigned long offset,
10ad52116c3a46 Matias Ezequiel Vara Larsen 2023-10-18  199  			 unsigned long bytes)
f40a28679e0b7c Anton Yakovlev              2021-03-02 @200  {
f40a28679e0b7c Anton Yakovlev              2021-03-02  201  	struct virtio_snd *snd = vss->snd;
f40a28679e0b7c Anton Yakovlev              2021-03-02  202  	struct virtio_device *vdev = snd->vdev;
f40a28679e0b7c Anton Yakovlev              2021-03-02  203  	struct virtqueue *vqueue = virtsnd_pcm_queue(vss)->vqueue;
10ad52116c3a46 Matias Ezequiel Vara Larsen 2023-10-18  204  	unsigned long period_bytes = snd_pcm_lib_period_bytes(vss->substream);
10ad52116c3a46 Matias Ezequiel Vara Larsen 2023-10-18  205  	unsigned long start, end, i;
10ad52116c3a46 Matias Ezequiel Vara Larsen 2023-10-18  206  	unsigned int msg_count = vss->msg_count;
f40a28679e0b7c Anton Yakovlev              2021-03-02  207  	bool notify = false;
10ad52116c3a46 Matias Ezequiel Vara Larsen 2023-10-18  208  	int rc;
f40a28679e0b7c Anton Yakovlev              2021-03-02  209  
10ad52116c3a46 Matias Ezequiel Vara Larsen 2023-10-18  210  	start = offset / period_bytes;
10ad52116c3a46 Matias Ezequiel Vara Larsen 2023-10-18  211  	end = (offset + bytes - 1) / period_bytes;
f40a28679e0b7c Anton Yakovlev              2021-03-02  212  
10ad52116c3a46 Matias Ezequiel Vara Larsen 2023-10-18  213  	for (i = start; i <= end; i++) {
f40a28679e0b7c Anton Yakovlev              2021-03-02  214  		struct virtio_pcm_msg *msg = vss->msgs[i];
f40a28679e0b7c Anton Yakovlev              2021-03-02  215  		struct scatterlist *psgs[] = {
f40a28679e0b7c Anton Yakovlev              2021-03-02  216  			&msg->sgs[PCM_MSG_SG_XFER],
f40a28679e0b7c Anton Yakovlev              2021-03-02  217  			&msg->sgs[PCM_MSG_SG_DATA],
f40a28679e0b7c Anton Yakovlev              2021-03-02  218  			&msg->sgs[PCM_MSG_SG_STATUS]
f40a28679e0b7c Anton Yakovlev              2021-03-02  219  		};
10ad52116c3a46 Matias Ezequiel Vara Larsen 2023-10-18  220  		unsigned long n;
10ad52116c3a46 Matias Ezequiel Vara Larsen 2023-10-18  221  
10ad52116c3a46 Matias Ezequiel Vara Larsen 2023-10-18  222  		n = period_bytes - (offset % period_bytes);
10ad52116c3a46 Matias Ezequiel Vara Larsen 2023-10-18  223  		if (n > bytes)
10ad52116c3a46 Matias Ezequiel Vara Larsen 2023-10-18  224  			n = bytes;
f40a28679e0b7c Anton Yakovlev              2021-03-02  225  
10ad52116c3a46 Matias Ezequiel Vara Larsen 2023-10-18  226  		msg->length += n;
10ad52116c3a46 Matias Ezequiel Vara Larsen 2023-10-18  227  		if (msg->length == period_bytes) {
f40a28679e0b7c Anton Yakovlev              2021-03-02  228  			msg->xfer.stream_id = cpu_to_le32(vss->sid);
f40a28679e0b7c Anton Yakovlev              2021-03-02  229  			memset(&msg->status, 0, sizeof(msg->status));
f40a28679e0b7c Anton Yakovlev              2021-03-02  230  
f40a28679e0b7c Anton Yakovlev              2021-03-02  231  			if (vss->direction == SNDRV_PCM_STREAM_PLAYBACK)
f40a28679e0b7c Anton Yakovlev              2021-03-02  232  				rc = virtqueue_add_sgs(vqueue, psgs, 2, 1, msg,
f40a28679e0b7c Anton Yakovlev              2021-03-02  233  						       GFP_ATOMIC);
f40a28679e0b7c Anton Yakovlev              2021-03-02  234  			else
f40a28679e0b7c Anton Yakovlev              2021-03-02  235  				rc = virtqueue_add_sgs(vqueue, psgs, 1, 2, msg,
f40a28679e0b7c Anton Yakovlev              2021-03-02  236  						       GFP_ATOMIC);
f40a28679e0b7c Anton Yakovlev              2021-03-02  237  
f40a28679e0b7c Anton Yakovlev              2021-03-02  238  			if (rc) {
f40a28679e0b7c Anton Yakovlev              2021-03-02  239  				dev_err(&vdev->dev,
f40a28679e0b7c Anton Yakovlev              2021-03-02  240  					"SID %u: failed to send I/O message\n",
f40a28679e0b7c Anton Yakovlev              2021-03-02  241  					vss->sid);
f40a28679e0b7c Anton Yakovlev              2021-03-02  242  				return rc;
f40a28679e0b7c Anton Yakovlev              2021-03-02  243  			}
f40a28679e0b7c Anton Yakovlev              2021-03-02  244  
f40a28679e0b7c Anton Yakovlev              2021-03-02  245  			vss->msg_count++;
f40a28679e0b7c Anton Yakovlev              2021-03-02  246  		}
f40a28679e0b7c Anton Yakovlev              2021-03-02  247  
10ad52116c3a46 Matias Ezequiel Vara Larsen 2023-10-18  248  		offset = 0;
10ad52116c3a46 Matias Ezequiel Vara Larsen 2023-10-18  249  		bytes -= n;
10ad52116c3a46 Matias Ezequiel Vara Larsen 2023-10-18  250  	}
10ad52116c3a46 Matias Ezequiel Vara Larsen 2023-10-18  251  
10ad52116c3a46 Matias Ezequiel Vara Larsen 2023-10-18  252  	if (msg_count == vss->msg_count)
10ad52116c3a46 Matias Ezequiel Vara Larsen 2023-10-18  253  		return 0;
10ad52116c3a46 Matias Ezequiel Vara Larsen 2023-10-18  254  
f40a28679e0b7c Anton Yakovlev              2021-03-02  255  	if (!(vss->features & (1U << VIRTIO_SND_PCM_F_MSG_POLLING)))
f40a28679e0b7c Anton Yakovlev              2021-03-02  256  		notify = virtqueue_kick_prepare(vqueue);
f40a28679e0b7c Anton Yakovlev              2021-03-02  257  
f40a28679e0b7c Anton Yakovlev              2021-03-02  258  	if (notify)
f40a28679e0b7c Anton Yakovlev              2021-03-02  259  		virtqueue_notify(vqueue);
f40a28679e0b7c Anton Yakovlev              2021-03-02  260  
f40a28679e0b7c Anton Yakovlev              2021-03-02  261  	return 0;
f40a28679e0b7c Anton Yakovlev              2021-03-02  262  }
f40a28679e0b7c Anton Yakovlev              2021-03-02  263  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
