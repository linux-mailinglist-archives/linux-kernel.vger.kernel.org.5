Return-Path: <linux-kernel+bounces-139544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A06C8A042B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 01:43:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 224771C21F6B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 23:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21CB93FE52;
	Wed, 10 Apr 2024 23:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="tOfgIubf"
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E233EA83
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 23:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712792592; cv=none; b=K4C4pkQWn/n9zX3GDH4ws2IYvfp7tf4JxtN1Opv0q1V33kWaTG+f9DcMxnnO9Pui1qlxOzd3tXJhZAANLuTdk6CYR/CUmQ5CLiAsMlG8ktA2kC+cvpZTnx7MwVCB3M/D2mmchnj3p/ud5aW4j81kaeE2/6D0Lv4ljM3+vBHoNc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712792592; c=relaxed/simple;
	bh=IqdwwrJPd3GJlIifxyj04ecjUnITr3Yy4Frv+BOv5fM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bGm2WJiwqY4Aqh2YRcCzAQjiI+VDwFAXUOIvR6nH8G4xEfis4h/K66a/JgpfI77hT0MX193RLHJKzvnZWb0MlwcNnHBLXAGd7aFcM3s2rZTT3ygYZGmTEKMNvovxTIe0KyvSemugjqdYbacKOsyr9LQt1hjr8Ml0S2JGTXkjcLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=tOfgIubf; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-434d0f63c31so14515261cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 16:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1712792588; x=1713397388; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EEVESkcf0S03MSgXfRfIQaKVMDK3fwo2I1//tbTNVXQ=;
        b=tOfgIubf3/ocYukDBb1IxGM6IqHASnkHizCEL0PvL+Sc2M6Tl4p3Q+F+NDs7/SSubf
         mBi+H0cZtPUQEhUyeheUs7mwQxqlsB2KkGswZJqv9l5Odn1q3wlicccdUzrmN5Or1Es6
         q1LVr4pxpikwLxLrGH2/vaUBb1K9lXaIpioYI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712792588; x=1713397388;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EEVESkcf0S03MSgXfRfIQaKVMDK3fwo2I1//tbTNVXQ=;
        b=DjoRBlSu0Agh4SLWoKAJ8GfyYLUuYar3ZdRTPnY2IInD8Y3m9WMWFPEnXISi9ohdDm
         7JIDAV0EhiZaCZDX2t2c9zSkISEUVvPsT08a+QLFyF4LHe2cves/4KfzZGlr8alIB2Jt
         DSd5Kz+KkpL6uFOCTWi7zvNMwagtOof+pOlxf6CSkfDBQx6aOxJqzj7Kq5j/tTYJK+66
         zKNS1kBejYFmO/BGGyg9ZJAD+oOEXG7pDHyEBu4q9AsORXLSXfT0yx6j/wZV+0HfyKIR
         7ZBPE8QQoH/bUreCZnv/yf2BiQL/GUdR9x/92fJq9R4qGpEf9L5UaHbkHGjurpE1Iqhq
         8QBw==
X-Gm-Message-State: AOJu0YybhMa3ePxzWoIS6mFY4Gk3q6WX9NzYumwYeDGVl7LN559+Zx4s
	qoFbKWoN/aP7SBnd0EaadqyOOoL3cc9U4e0PoFqQnMdlZm7NSWNHhKSy50tYaIg=
X-Google-Smtp-Source: AGHT+IHhMI9p8LiUmOEhI4Zhyv4Ub3Hen9Jkjl+UE8ibgFi4W+Ov80I6AzGhOsyLJ+8N4BfQpioxYA==
X-Received: by 2002:ac8:5907:0:b0:434:cfe4:90fe with SMTP id 7-20020ac85907000000b00434cfe490femr5580676qty.38.1712792587604;
        Wed, 10 Apr 2024 16:43:07 -0700 (PDT)
Received: from LQ3V64L9R2 ([74.92.140.241])
        by smtp.gmail.com with ESMTPSA id w14-20020ac84d0e000000b004364e61ce09sm158979qtv.66.2024.04.10.16.43.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 16:43:07 -0700 (PDT)
Date: Wed, 10 Apr 2024 19:43:04 -0400
From: Joe Damato <jdamato@fastly.com>
To: "Nambiar, Amritha" <amritha.nambiar@intel.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org, sridhar.samudrala@intel.com,
	nalramli@fastly.com, Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [intel-next 1/2] net/i40e: link NAPI instances to queues and IRQs
Message-ID: <ZhckCOFplMR0GMjr@LQ3V64L9R2>
References: <20240410043936.206169-1-jdamato@fastly.com>
 <20240410043936.206169-2-jdamato@fastly.com>
 <bb0fbd29-c098-4a62-9217-c9fd1a450250@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bb0fbd29-c098-4a62-9217-c9fd1a450250@intel.com>

On Wed, Apr 10, 2024 at 02:10:52AM -0700, Nambiar, Amritha wrote:
> On 4/9/2024 9:39 PM, Joe Damato wrote:
> > Make i40e compatible with the newly added netlink queue GET APIs.
> > 
> > $ ./cli.py --spec ../../../Documentation/netlink/specs/netdev.yaml \
> >    --do queue-get --json '{"ifindex": 3, "id": 1, "type": "rx"}'
> > 
> > {'id': 1, 'ifindex': 3, 'napi-id': 162, 'type': 'rx'}
> > 
> > $ ./cli.py --spec ../../../Documentation/netlink/specs/netdev.yaml \
> >    --do napi-get --json '{"id": 162}'
> > 
> > {'id': 162, 'ifindex': 3, 'irq': 136}
> > 
> > The above output suggests that irq 136 was allocated for queue 1, which has
> > a NAPI ID of 162.
> > 
> > To double check this is correct, the IRQ to queue mapping can be verified
> > by checking /proc/interrupts:
> > 
> > $ cat /proc/interrupts  | grep 136\: | \
> >    awk '{print "irq: " $1 " name " $76}'
> > 
> > irq: 136: name i40e-vlan300-TxRx-1
> > 
> > Suggests that queue 1 has IRQ 136, as expected.
> > 
> > Signed-off-by: Joe Damato <jdamato@fastly.com>
> > ---
> >   drivers/net/ethernet/intel/i40e/i40e.h      |  2 +
> >   drivers/net/ethernet/intel/i40e/i40e_main.c | 58 +++++++++++++++++++++
> >   drivers/net/ethernet/intel/i40e/i40e_txrx.c |  4 ++
> >   3 files changed, 64 insertions(+)
> > 
> > diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
> > index 2fbabcdb5bb5..5900ed5c7170 100644
> > --- a/drivers/net/ethernet/intel/i40e/i40e.h
> > +++ b/drivers/net/ethernet/intel/i40e/i40e.h
> > @@ -1267,6 +1267,8 @@ int i40e_ioctl(struct net_device *netdev, struct ifreq *ifr, int cmd);
> >   int i40e_open(struct net_device *netdev);
> >   int i40e_close(struct net_device *netdev);
> >   int i40e_vsi_open(struct i40e_vsi *vsi);
> > +void i40e_queue_set_napi(struct i40e_vsi *vsi, unsigned int queue_index,
> > +			 enum netdev_queue_type type, struct napi_struct *napi);
> >   void i40e_vlan_stripping_disable(struct i40e_vsi *vsi);
> >   int i40e_add_vlan_all_mac(struct i40e_vsi *vsi, s16 vid);
> >   int i40e_vsi_add_vlan(struct i40e_vsi *vsi, u16 vid);
> > diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
> > index 0bdcdea0be3e..6384a0c73a05 100644
> > --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
> > +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
> > @@ -3448,6 +3448,58 @@ static struct xsk_buff_pool *i40e_xsk_pool(struct i40e_ring *ring)
> >   	return xsk_get_pool_from_qid(ring->vsi->netdev, qid);
> >   }
> > +/**
> > + * __i40e_queue_set_napi - Set the napi instance for the queue
> > + * @dev: device to which NAPI and queue belong
> > + * @queue_index: Index of queue
> > + * @type: queue type as RX or TX
> > + * @napi: NAPI context
> > + * @locked: is the rtnl_lock already held
> > + *
> > + * Set the napi instance for the queue. Caller indicates the lock status.
> > + */
> > +static void
> > +__i40e_queue_set_napi(struct net_device *dev, unsigned int queue_index,
> > +		      enum netdev_queue_type type, struct napi_struct *napi,
> > +		      bool locked)
> > +{
> > +	if (!locked)
> > +		rtnl_lock();
> > +	netif_queue_set_napi(dev, queue_index, type, napi);
> > +	if (!locked)
> > +		rtnl_unlock();
> > +}
> > +
> > +/**
> > + * i40e_queue_set_napi - Set the napi instance for the queue
> > + * @vsi: VSI being configured
> > + * @queue_index: Index of queue
> > + * @type: queue type as RX or TX
> > + * @napi: NAPI context
> > + *
> > + * Set the napi instance for the queue. The rtnl lock state is derived from the
> > + * execution path.
> > + */
> > +void
> > +i40e_queue_set_napi(struct i40e_vsi *vsi, unsigned int queue_index,
> > +		    enum netdev_queue_type type, struct napi_struct *napi)
> > +{
> > +	struct i40e_pf *pf = vsi->back;
> > +
> > +	if (!vsi->netdev)
> > +		return;
> > +
> > +	if (current_work() == &pf->service_task ||
> > +	    test_bit(__I40E_PF_RESET_REQUESTED, pf->state) ||
> 
> I think we might need something like ICE_PREPARED_FOR_RESET which detects
> all kinds of resets(PFR/CORE/GLOBR). __I40E_PF_RESET_REQUESTED handles PFR
> only. So, this might assert for RTNL lock on CORER/GLOBR.

The i40e code is a bit tricky so I'm not sure about these cases. Here's
what it looks like to me, but hopefully Intel can weigh-in here as well.

As some one who is not an expert in i40e, what follows is a guess that is
likely wrong ;)

The __I40E_GLOBAL_RESET_REQUESTED case it looks to me (I could totally
be wrong here) that the i40e_reset_subtask calls i40e_rebuild with
lock_acquired = false. In this case, we want __i40e_queue_set_napi to
pass locked = true (because i40e_rebuild will acquire the lock for us).

The __I40E_CORE_RESET_REQUESTED case appears to be the same as the
__I40E_GLOBAL_RESET_REQUESTED case in that i40e_rebuild is called with
lock_acquired = false meaning we also want __i40e_queue_set_napi to pass
locked = true (because i40e_rebuild will acquire the lock for us).

__I40E_PF_RESET_REQUESTED is more complex.

It seems:
          When the __I40E_PF_RESET_REQUESTED bit is set in:
            - i40e_handle_lldp_event
            - i40e_tx_timeout
            - i40e_intr
            - i40e_resume_port_tx
            - i40e_suspend_port_tx
            - i40e_hw_dcb_config

          then: i40e_service_event_schedule is called which queues
          i40e_service_task, which calls i40e_reset_subtask, which
          clears the __I40E_PF_RESET_REQUESTED bit and calls
          i40e_do_reset passing lock_acquired = false. In the
          __I40E_PF_RESET_REQUESTED case, i40e_reset_and_rebuild
	  called with lock_acquired = false again and passed through to
	  i40e_rebuild which will take rtnl on its own. This means
          in these cases, __i40e_queue_set_napi can pass locked = true.

          However...

            - i40e_set_features
            - i40e_ndo_bridge_setlink
            - i40e_create_queue_channel
            - i40e_configure_queue_channels
            - Error case in i40e_vsi_open

          call i40e_do_reset directly and pass lock_acquired = true so
          i40e_reset_and_rebuild will not take the RTNL.

	  Important assumption: I assume that passing lock_acquired = true
	  means that the lock really was previously acquired (and not simply
	  unnecessary and not taken ?).

	  If that is correct, then __i40e_queue_set_napi should also not take the rtnl (e.g.
          locked = true).

Again, I could be totally off here, but it looks like when:

  (current_work() == &pf->service_task) && test_bit(__I40E_PF_RESET_REQUESTED, pf->state)

is true, we want to call __i40e_queue_set_napi with locked = true,

and also all the other cases we want __i40e_queue_set_napi with locked = true

> > +	    test_bit(__I40E_DOWN, pf->state) ||
> > +	    test_bit(__I40E_SUSPENDED, pf->state))
> > +		__i40e_queue_set_napi(vsi->netdev, queue_index, type, napi,
> > +				      false);
> > +	else
> > +		__i40e_queue_set_napi(vsi->netdev, queue_index, type, napi,
> > +				      true);

I *think* (but honestly... I have no idea) the correct if statement *might* be
something like:

  /* __I40E_PF_RESET_REQUESTED via the service_task will
   * call i40e_rebuild with lock_acquired = false, causing rtnl to be
   * taken, meaning __i40e_queue_set_napi should *NOT* take the lock.
   *
   * __I40E_PF_RESET_REQUESTED when set directly and not via the
   * service task, i40e_reset is called with lock_acquired = true,
   * implying that the rtnl was already taken (and, more
   * specifically, the lock was not simply unnecessary and skipped)
   * and so __i40e_queue_set_napi should *NOT* take the lock.
   *
   * __I40E_GLOBAL_RESET_REQUESTED and __I40E_CORE_RESET_REQUESTED
   * trigger the service_task (via i40e_intr) which will cause
   * i40e_rebuild to acquire rtnl and so __i40e_queue_set_napi should
   * not acquire it.
   */
  if (current_work() == &pf->service_task ||
      test_bit(__I40E_PF_RESET_REQUESTED, pf->state) ||
      test_bit(__I40E_GLOBAL_RESET_REQUESTED, pf->state) ||
      test_bit(__I40E_CORE_RESET_REQUESTED, pf->state))
          __i40e_queue_set_napi(vsi->netdev, queue_index, type, napi,
                                true);
  else if (test_bit(__I40E_DOWN, pf->state) ||
           test_bit(__I40E_SUSPENDED, pf->state))
          __i40e_queue_set_napi(vsi->netdev, queue_index, type, napi,
                                false);
  else
          __i40e_queue_set_napi(vsi->netdev, queue_index, type, napi,
                                true);

I suppose to figure this out, I'd need to investigate all cases where
i40e_rebuild is called with lock_acquired = true to ensure that the lock was
actually acquired (and not just unnecessary).

Unless some one who knows about i40e can answer this question more
definitively.

> > +}
> > +
> >   /**
> >    * i40e_configure_tx_ring - Configure a transmit ring context and rest
> >    * @ring: The Tx ring to configure
> > @@ -3558,6 +3610,8 @@ static int i40e_configure_tx_ring(struct i40e_ring *ring)
> >   	/* cache tail off for easier writes later */
> >   	ring->tail = hw->hw_addr + I40E_QTX_TAIL(pf_q);
> > +	i40e_queue_set_napi(vsi, ring->queue_index, NETDEV_QUEUE_TYPE_TX,
> > +			    &ring->q_vector->napi);
> 
> I am not sure very sure of this, have you tested this for the reset/rebuild
> path as well (example: ethtool -L and change queues). Just wondering if this
> path is taken for first time VSI init or additionally for any VSI rebuilds
> as well.

Can you explain more about what your concern is? I'm not sure I follow.
Was the concern just that on rebuild this code path might not be
executed because the driver might take a different path?

If so, I traced the code (and tested with ethtool):

When the device is probed:

i40e_probe
  i40e_vsi_open
    i40e_vsi_configure
      i40e_vsi_configure_rx
        i40e_configure_rx_ring
      i40e_vsi_configure_tx
        i40e_configure_tx_ring

When you use ethtool to change the channel count:

i40e_set_channels
  i40e_reconfig_rss_queues
    i40e_reset_and_rebuild
      i40e_rebuild
        i40e_pf_unquiesce_all_vsi
          i40e_unquiesce_vsi
            i40e_vsi_open
              [.. the call stack above for i40e_vsi_open ..]

Are those the two paths you had in mind or were there other ones? FWIW, using
ethtool to change the channel count followed by using the cli.py returns what
appears to be correct data, so I think the ethtool -L case is covered.

Let me know if I am missing any cases you had in mind or if this answers your
question.

> >   	return 0;
> >   }
> > @@ -3716,6 +3770,8 @@ static int i40e_configure_rx_ring(struct i40e_ring *ring)
> >   			 ring->queue_index, pf_q);
> >   	}
> > +	i40e_queue_set_napi(vsi, ring->queue_index, NETDEV_QUEUE_TYPE_RX,
> > +			    &ring->q_vector->napi);
> > 
> Same as above.
> 
>   	return 0;
> >   }
> > @@ -4178,6 +4234,8 @@ static int i40e_vsi_request_irq_msix(struct i40e_vsi *vsi, char *basename)
> >   		q_vector->affinity_notify.notify = i40e_irq_affinity_notify;
> >   		q_vector->affinity_notify.release = i40e_irq_affinity_release;
> >   		irq_set_affinity_notifier(irq_num, &q_vector->affinity_notify);
> > +		netif_napi_set_irq(&q_vector->napi, q_vector->irq_num);
> > +
> >   		/* Spread affinity hints out across online CPUs.
> >   		 *
> >   		 * get_cpu_mask returns a static constant mask with
> > diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> > index 64d198ed166b..d380885ff26d 100644
> > --- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> > +++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> > @@ -821,6 +821,8 @@ void i40e_clean_tx_ring(struct i40e_ring *tx_ring)
> >   void i40e_free_tx_resources(struct i40e_ring *tx_ring)
> >   {
> >   	i40e_clean_tx_ring(tx_ring);
> > +	i40e_queue_set_napi(tx_ring->vsi, tx_ring->queue_index,
> > +			    NETDEV_QUEUE_TYPE_TX, NULL);
> >   	kfree(tx_ring->tx_bi);
> >   	tx_ring->tx_bi = NULL;
> > @@ -1526,6 +1528,8 @@ void i40e_clean_rx_ring(struct i40e_ring *rx_ring)
> >   void i40e_free_rx_resources(struct i40e_ring *rx_ring)
> >   {
> >   	i40e_clean_rx_ring(rx_ring);
> > +	i40e_queue_set_napi(rx_ring->vsi, rx_ring->queue_index,
> > +			    NETDEV_QUEUE_TYPE_RX, NULL);
> >   	if (rx_ring->vsi->type == I40E_VSI_MAIN)
> >   		xdp_rxq_info_unreg(&rx_ring->xdp_rxq);
> >   	rx_ring->xdp_prog = NULL;

