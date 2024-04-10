Return-Path: <linux-kernel+bounces-137894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81A4C89E913
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 06:40:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38C62284A32
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 04:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88279168CC;
	Wed, 10 Apr 2024 04:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="qjfLpDzr"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 043E5107B6
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 04:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712723987; cv=none; b=frKa6z9ZjjlOBrnlt/ZRK4YW8ZEPcN3vhGTpFJkFKeGsQwSp2eAMKG+dGLAD2DifV42ly2+epWNISWHEvDqOiJBbFN8d6X33gdr2WjLDxxIqGFudxn0fF4lWPlYo8e1qyT6kw3wzVagQb9kfDaco+sR78IBT7skhSlwoCq/gQZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712723987; c=relaxed/simple;
	bh=+aWoCTLRMEia/7VjS+8wDfmv4sTpAQMvPaISA6TV6lQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iuw1eH9LTkznt5hQsY6FezhsvNKM4CAk7BbL67lUCIVmKg66WKGOLdXIOQLaCKRZITDRrayNhAD+k/1y5/pU6fX9zhHNFjq3KCiDdW/nMLh5Y5CezLSEU23FgvjmcmNBKOyOdmCxEbZ4BH9rDdXMji9dqnjdtvdoMtbK94QwMOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=qjfLpDzr; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2a502547460so2018600a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 21:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1712723984; x=1713328784; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5x0y6JOjRs9D46M/YJwxsoJQEODb8B73PIsmrjKpgsY=;
        b=qjfLpDzrIuZLnXsMmjOKRmjEK0xn+SlbIQ855rvr2bUrzeDoUJm1wAuLikBW3cnXJ5
         C4J29jzUXlzYOwFxMvJ9WxB2EBGadsT1+/gxXLTnktW4N1zJkOrTwP+pPXxt5PUdlVf5
         r9/nVUzaZvVYgEr2Cyw1rfSMUD3fNJp1BcquU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712723984; x=1713328784;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5x0y6JOjRs9D46M/YJwxsoJQEODb8B73PIsmrjKpgsY=;
        b=BM9s5qD+lqjAbArrCP4adZ+lPgriqHbI6PTqYTzVbde6WFvg0xhE1qN2IzO2O10f69
         hN+nqjjoqTscXmIzE0kvSJnTTO4dBokTUwfj5U87oWsElGkpqrVUnwAhhtjrB7Pgo1Fc
         9HLD8ZhgnImJGkCyPiOmO+m5M9T7PZDxoMUPOdp6oAx3+FhNjLAdW+KRuulkf8Lnd4sa
         rlZAJ0o8CgKPz1a/qfbfhD5Oy33RXeCB0lRuIAy5UZ4YFHjQqEurvuzvnc12/70ekC+y
         ZfS+6Bb6Nq9sMsdwLtjBN/vP22xFxnYm33ZC5KzX822yTpxBsNO/N04VUObWhKia7H5m
         pt/w==
X-Gm-Message-State: AOJu0YwkOEIfcbCMulgvnaxWRaKk9WAqE415otkTimKInccVAMlzS/Ev
	rCHMRKR24A8fS/o2iMkVAJ/1OJMyBYfVeoN76z0XEdGii4iCRQn8WnKcLX/1kfC+gc8Z8Cj5PeF
	sA5cFqhLanlXn1PYEpHNlB56EtW9VU3oYQ5ePTfWauhJ61fQ+g50uTehEGwzYBqQhqOJzyoR0yQ
	B0W3vltdAm6MjC415PvgExWKhCHOQXW+zUHAfWrL/2VDY=
X-Google-Smtp-Source: AGHT+IEk7YATwthbk+mb9fqMLJPGxEBJa32KoCGCBl7Dyq/xvT3FTYwVMeMq3y3WDq6N/pse9NqSxQ==
X-Received: by 2002:a17:90b:2287:b0:2a5:d7ed:2d18 with SMTP id kx7-20020a17090b228700b002a5d7ed2d18mr329439pjb.20.1712723984438;
        Tue, 09 Apr 2024 21:39:44 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id gn4-20020a17090ac78400b002a5d71d48e8sm260773pjb.39.2024.04.09.21.39.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 21:39:44 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org
Cc: sridhar.samudrala@intel.com,
	amritha.nambiar@intel.com,
	nalramli@fastly.com,
	Joe Damato <jdamato@fastly.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [intel-next 1/2] net/i40e: link NAPI instances to queues and IRQs
Date: Wed, 10 Apr 2024 04:39:34 +0000
Message-Id: <20240410043936.206169-2-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240410043936.206169-1-jdamato@fastly.com>
References: <20240410043936.206169-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make i40e compatible with the newly added netlink queue GET APIs.

$ ./cli.py --spec ../../../Documentation/netlink/specs/netdev.yaml \
  --do queue-get --json '{"ifindex": 3, "id": 1, "type": "rx"}'

{'id': 1, 'ifindex': 3, 'napi-id': 162, 'type': 'rx'}

$ ./cli.py --spec ../../../Documentation/netlink/specs/netdev.yaml \
  --do napi-get --json '{"id": 162}'

{'id': 162, 'ifindex': 3, 'irq': 136}

The above output suggests that irq 136 was allocated for queue 1, which has
a NAPI ID of 162.

To double check this is correct, the IRQ to queue mapping can be verified
by checking /proc/interrupts:

$ cat /proc/interrupts  | grep 136\: | \
  awk '{print "irq: " $1 " name " $76}'

irq: 136: name i40e-vlan300-TxRx-1

Suggests that queue 1 has IRQ 136, as expected.

Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 drivers/net/ethernet/intel/i40e/i40e.h      |  2 +
 drivers/net/ethernet/intel/i40e/i40e_main.c | 58 +++++++++++++++++++++
 drivers/net/ethernet/intel/i40e/i40e_txrx.c |  4 ++
 3 files changed, 64 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index 2fbabcdb5bb5..5900ed5c7170 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -1267,6 +1267,8 @@ int i40e_ioctl(struct net_device *netdev, struct ifreq *ifr, int cmd);
 int i40e_open(struct net_device *netdev);
 int i40e_close(struct net_device *netdev);
 int i40e_vsi_open(struct i40e_vsi *vsi);
+void i40e_queue_set_napi(struct i40e_vsi *vsi, unsigned int queue_index,
+			 enum netdev_queue_type type, struct napi_struct *napi);
 void i40e_vlan_stripping_disable(struct i40e_vsi *vsi);
 int i40e_add_vlan_all_mac(struct i40e_vsi *vsi, s16 vid);
 int i40e_vsi_add_vlan(struct i40e_vsi *vsi, u16 vid);
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 0bdcdea0be3e..6384a0c73a05 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -3448,6 +3448,58 @@ static struct xsk_buff_pool *i40e_xsk_pool(struct i40e_ring *ring)
 	return xsk_get_pool_from_qid(ring->vsi->netdev, qid);
 }
 
+/**
+ * __i40e_queue_set_napi - Set the napi instance for the queue
+ * @dev: device to which NAPI and queue belong
+ * @queue_index: Index of queue
+ * @type: queue type as RX or TX
+ * @napi: NAPI context
+ * @locked: is the rtnl_lock already held
+ *
+ * Set the napi instance for the queue. Caller indicates the lock status.
+ */
+static void
+__i40e_queue_set_napi(struct net_device *dev, unsigned int queue_index,
+		      enum netdev_queue_type type, struct napi_struct *napi,
+		      bool locked)
+{
+	if (!locked)
+		rtnl_lock();
+	netif_queue_set_napi(dev, queue_index, type, napi);
+	if (!locked)
+		rtnl_unlock();
+}
+
+/**
+ * i40e_queue_set_napi - Set the napi instance for the queue
+ * @vsi: VSI being configured
+ * @queue_index: Index of queue
+ * @type: queue type as RX or TX
+ * @napi: NAPI context
+ *
+ * Set the napi instance for the queue. The rtnl lock state is derived from the
+ * execution path.
+ */
+void
+i40e_queue_set_napi(struct i40e_vsi *vsi, unsigned int queue_index,
+		    enum netdev_queue_type type, struct napi_struct *napi)
+{
+	struct i40e_pf *pf = vsi->back;
+
+	if (!vsi->netdev)
+		return;
+
+	if (current_work() == &pf->service_task ||
+	    test_bit(__I40E_PF_RESET_REQUESTED, pf->state) ||
+	    test_bit(__I40E_DOWN, pf->state) ||
+	    test_bit(__I40E_SUSPENDED, pf->state))
+		__i40e_queue_set_napi(vsi->netdev, queue_index, type, napi,
+				      false);
+	else
+		__i40e_queue_set_napi(vsi->netdev, queue_index, type, napi,
+				      true);
+}
+
 /**
  * i40e_configure_tx_ring - Configure a transmit ring context and rest
  * @ring: The Tx ring to configure
@@ -3558,6 +3610,8 @@ static int i40e_configure_tx_ring(struct i40e_ring *ring)
 	/* cache tail off for easier writes later */
 	ring->tail = hw->hw_addr + I40E_QTX_TAIL(pf_q);
 
+	i40e_queue_set_napi(vsi, ring->queue_index, NETDEV_QUEUE_TYPE_TX,
+			    &ring->q_vector->napi);
 	return 0;
 }
 
@@ -3716,6 +3770,8 @@ static int i40e_configure_rx_ring(struct i40e_ring *ring)
 			 ring->queue_index, pf_q);
 	}
 
+	i40e_queue_set_napi(vsi, ring->queue_index, NETDEV_QUEUE_TYPE_RX,
+			    &ring->q_vector->napi);
 	return 0;
 }
 
@@ -4178,6 +4234,8 @@ static int i40e_vsi_request_irq_msix(struct i40e_vsi *vsi, char *basename)
 		q_vector->affinity_notify.notify = i40e_irq_affinity_notify;
 		q_vector->affinity_notify.release = i40e_irq_affinity_release;
 		irq_set_affinity_notifier(irq_num, &q_vector->affinity_notify);
+		netif_napi_set_irq(&q_vector->napi, q_vector->irq_num);
+
 		/* Spread affinity hints out across online CPUs.
 		 *
 		 * get_cpu_mask returns a static constant mask with
diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index 64d198ed166b..d380885ff26d 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -821,6 +821,8 @@ void i40e_clean_tx_ring(struct i40e_ring *tx_ring)
 void i40e_free_tx_resources(struct i40e_ring *tx_ring)
 {
 	i40e_clean_tx_ring(tx_ring);
+	i40e_queue_set_napi(tx_ring->vsi, tx_ring->queue_index,
+			    NETDEV_QUEUE_TYPE_TX, NULL);
 	kfree(tx_ring->tx_bi);
 	tx_ring->tx_bi = NULL;
 
@@ -1526,6 +1528,8 @@ void i40e_clean_rx_ring(struct i40e_ring *rx_ring)
 void i40e_free_rx_resources(struct i40e_ring *rx_ring)
 {
 	i40e_clean_rx_ring(rx_ring);
+	i40e_queue_set_napi(rx_ring->vsi, rx_ring->queue_index,
+			    NETDEV_QUEUE_TYPE_RX, NULL);
 	if (rx_ring->vsi->type == I40E_VSI_MAIN)
 		xdp_rxq_info_unreg(&rx_ring->xdp_rxq);
 	rx_ring->xdp_prog = NULL;
-- 
2.25.1


