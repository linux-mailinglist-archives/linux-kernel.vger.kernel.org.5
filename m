Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9E898044DC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 03:29:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346398AbjLEC3E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 21:29:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344127AbjLEC2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 21:28:50 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FA8130D0;
        Mon,  4 Dec 2023 18:27:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701743226; x=1733279226;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kOpRCM/Alytm6Ynqn23OIlROnY/GAJM/+vJVGPgtI58=;
  b=PHy9zCzEY6L4VlLz9TDVuY9apzg7jdcwqxJzKYoOye53zw4QhGRAx6ar
   tGpppxa4Msf/+Ic7PAgylu2LROYRQjsr3fC3lpq/fcp+NIkecVbT0zwLG
   lo4Vo1tVkJ1wKfK6/vz4bBdCTwbp24W/oTyop3VXleGm9GDaX8FsyD9hh
   L0MERMCigohU54IXkIQdwLvxjehKfSmQuHTSTS7ru67TxfFgrXIbgjQce
   mnKVqKqzEvPUKbhaV+wr6xX2BHhotXnP+Nita3LvGkW0sUm5JKq0B/haY
   Q44vM0U8nvcvCsuA25K7v3dc0JDEUAw/KtGgdC6c+gV4TARIknpOwLj1C
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="706160"
X-IronPort-AV: E=Sophos;i="6.04,251,1695711600"; 
   d="scan'208";a="706160"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2023 18:27:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="770756219"
X-IronPort-AV: E=Sophos;i="6.04,251,1695711600"; 
   d="scan'208";a="770756219"
Received: from rex-z390-aorus-pro.sh.intel.com ([10.239.161.21])
  by orsmga002.jf.intel.com with ESMTP; 04 Dec 2023 18:26:57 -0800
From:   Rex Zhang <rex.zhang@intel.com>
To:     tom.zanussi@linux.intel.com
Cc:     dave.jiang@intel.com, davem@davemloft.net,
        dmaengine@vger.kernel.org, fenghua.yu@intel.com,
        giovanni.cabiddu@intel.com, herbert@gondor.apana.org.au,
        james.guilford@intel.com, kanchana.p.sridhar@intel.com,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        pavel@ucw.cz, rex.zhang@intel.com, tony.luck@intel.com,
        vinodh.gopal@intel.com, vkoul@kernel.org, wajdi.k.feghali@intel.com
Subject: Re: [PATCH v11 11/14] crypto: iaa - Add support for deflate-iaa compression algorithm
Date:   Tue,  5 Dec 2023 10:26:55 +0800
Message-Id: <20231205022655.3616965-1-rex.zhang@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <1a44f8396c6b7014de9b9bde4d5f5a4dbf0ef7a1.camel@linux.intel.com>
References: <1a44f8396c6b7014de9b9bde4d5f5a4dbf0ef7a1.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tom,

On 2023-12-04 at 15:41:46 -0600, Tom Zanussi wrote:
> Hi Rex,
> 
> On Mon, 2023-12-04 at 23:00 +0800, Rex Zhang wrote:
> > Hi, Tom,
> > 
> > On 2023-12-01 at 14:10:32 -0600, Tom Zanussi wrote:
> > 
> > [snip]
> > 
> > > +static int iaa_wq_put(struct idxd_wq *wq)
> > > +{
> > > +       struct idxd_device *idxd = wq->idxd;
> > > +       struct iaa_wq *iaa_wq;
> > > +       bool free = false;
> > > +       int ret = 0;
> > > +
> > > +       spin_lock(&idxd->dev_lock);
> > > +       iaa_wq = idxd_wq_get_private(wq);
> > > +       if (iaa_wq) {
> > > +               iaa_wq->ref--;
> > > +               if (iaa_wq->ref == 0 && iaa_wq->remove) {
> > > +                       __free_iaa_wq(iaa_wq);
> > > +                       idxd_wq_set_private(wq, NULL);
> > > +                       free = true;
> > > +               }
> > > +               idxd_wq_put(wq);
> > > +       } else {
> > > +               ret = -ENODEV;
> > > +       }
> > > +       spin_unlock(&idxd->dev_lock);
> > __free_iaa_wq() may cause schedule, whether it should be move out of
> > the
> > context between spin_lock() and spin_unlock()?
> 
> Yeah, I suppose it makes more sense to have it below anyway, will move
> it there.
> 
> > > +       if (free)
> > > +               kfree(iaa_wq);
> > > +
> > > +       return ret;
> > > +}
> > 
> > [snip]
> > 
> > > @@ -800,12 +1762,38 @@ static void iaa_crypto_remove(struct
> > > idxd_dev *idxd_dev)
> > >  
> > >         remove_iaa_wq(wq);
> > >  
> > > +       spin_lock(&idxd->dev_lock);
> > > +       iaa_wq = idxd_wq_get_private(wq);
> > > +       if (!iaa_wq) {
> > > +               spin_unlock(&idxd->dev_lock);
> > > +               pr_err("%s: no iaa_wq available to remove\n",
> > > __func__);
> > > +               goto out;
> > > +       }
> > > +
> > > +       if (iaa_wq->ref) {
> > > +               iaa_wq->remove = true;
> > > +       } else {
> > > +               wq = iaa_wq->wq;
> > > +               __free_iaa_wq(iaa_wq);
> > > +               idxd_wq_set_private(wq, NULL);
> > > +               free = true;
> > > +       }
> > > +       spin_unlock(&idxd->dev_lock);
> > __free_iaa_wq() may cause schedule, whether it should be move out of
> > the
> > context between spin_lock() and spin_unlock()?
> 
> Same.
> 
> > > +
> > > +       if (free)
> > > +               kfree(iaa_wq);
> > > +
> > >         idxd_drv_disable_wq(wq);
> > >         rebalance_wq_table();
> > >  
> > > -       if (nr_iaa == 0)
> > > +       if (nr_iaa == 0) {
> > > +               iaa_crypto_enabled = false;
> > Is it necessary to add iaa_unregister_compression_device() here?
> > All iaa devices are disabled cause the variable first_wq will be
> > true,
> > if enable wq, iaa_register_compression_device() will fail due to the
> > algorithm is existed.
> 
> No, this is required by review input from a previous version - the
> compression device can only be unregistered on module exit.
Do it mean disabling all WQs followed by enabling WQ is unacceptable?
User must do "rmmod iaa_crypto" before enabling WQ in this case.

Thanks.
> 
> Thanks,
> 
> Tom
> 
> > >                 free_wq_table();
> > > +               module_put(THIS_MODULE);
> > >  
> > > +               pr_info("iaa_crypto now DISABLED\n");
> > > +       }
> > > +out:
> > >         mutex_unlock(&iaa_devices_lock);
> > >         mutex_unlock(&wq->wq_lock);
> > >  }
> > 
> > [snip]
> > 
> > Thanks,
> > Rex Zhang
> > > -- 
> > > 2.34.1
> > > 
> 
