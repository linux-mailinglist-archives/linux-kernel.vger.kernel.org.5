Return-Path: <linux-kernel+bounces-41078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2799383EB6C
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 07:21:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89014B20F64
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 06:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1105241F6;
	Sat, 27 Jan 2024 06:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ejYCAxZP"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D139123760
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 06:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706336501; cv=none; b=GJzEXdNaFL9Qbsx2gZVQTr8ucozD9MSIgq6LLeYG9sWoSn1rVMyTO0TUOx7laM2Pj6kRWQ1g3RoJ2EfeFh00mqZ6Zwc4QmeOH73mhtq1UxFn6POE+cQV4cf49DxGal68jJ8ZLjEXpitQ2MRYrOgxFzEcHZptwvRa1vbe65iORlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706336501; c=relaxed/simple;
	bh=JCkPZcgSQQI8rbMvj1CS4blzDNWITwbgaXVyWWC8YtA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=V46bEoDqqwmSAsPg4PX97PxPvOuod0X1DiEmRfds6Qwtqq1JkP27Vi6KE9yIX7mdspTFKmAV8/JGyr3xHN5Zrce3ClJDBG6NfFWhY/a0DztC0FTBHtVG35Xxr80QqGN2/19ELSsshqnfO30eKBxu+F0t/ouh6+zu2tgm2FJtjEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ejYCAxZP; arc=none smtp.client-ip=192.55.52.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706336498; x=1737872498;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=JCkPZcgSQQI8rbMvj1CS4blzDNWITwbgaXVyWWC8YtA=;
  b=ejYCAxZP5yehbw6V+3lcxHzcC/OydtfjZqPk1nnngM7MZsmQI+f8Qcjo
   URCA7jQboIpcnurc0fObj/OUv0dITviqE1W15d/B+CBHMO6B8Ms2ibVTj
   ivbE4epGjDjHPi0+6N/+00GbDgDBOPzheS7lbXzHFmLV0kShydMyOQOld
   Tm5GC2p3wCayZLUSExJuMGt9UaJJReAmAeC67tv9uvynpb2iGMjYKAu33
   ZDEJa6EkUS7H8kR5G84rCeA7P3w/1lq3Tm1ICaqy2We2Ex7AMDS+vAGcg
   Nggcn8V78jw1zYnskON833cU+xYvbno7U70L4H+qgbZIMI/trNbI90hFa
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="433807116"
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="433807116"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2024 22:21:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="29299165"
Received: from lkp-server01.sh.intel.com (HELO 370188f8dc87) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 26 Jan 2024 22:21:35 -0800
Received: from kbuild by 370188f8dc87 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rTc4K-0001hm-3C;
	Sat, 27 Jan 2024 06:21:32 +0000
Date: Sat, 27 Jan 2024 14:21:11 +0800
From: kernel test robot <lkp@intel.com>
To: Walter Wu <walter-zh.wu@mediatek.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Nathan Chancellor <natechancellor@gmail.com>,
	Andrey Konovalov <andreyknvl@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>
Subject: drivers/media/dvb-frontends/cxd2841er.c:3376:12: warning: stack
 frame size (11032) exceeds limit (8192) in 'cxd2841er_set_frontend_tc'
Message-ID: <202401271419.4b5Fic5b-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   3a5879d495b226d0404098e3564462d5f1daa33b
commit: 02c587733c8161355a43e6e110c2e29bd0acff72 kasan: remove redundant config option
date:   2 years, 9 months ago
config: x86_64-randconfig-014-20240105 (https://download.01.org/0day-ci/archive/20240127/202401271419.4b5Fic5b-lkp@intel.com/config)
compiler: ClangBuiltLinux clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240127/202401271419.4b5Fic5b-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401271419.4b5Fic5b-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/media/dvb-frontends/cxd2841er.c:3376:12: warning: stack frame size (11032) exceeds limit (8192) in 'cxd2841er_set_frontend_tc' [-Wframe-larger-than]
    3376 | static int cxd2841er_set_frontend_tc(struct dvb_frontend *fe)
         |            ^
   1 warning generated.
--
>> drivers/media/dvb-frontends/nxt200x.c:1087:12: warning: stack frame size (15192) exceeds limit (8192) in 'nxt200x_init' [-Wframe-larger-than]
    1087 | static int nxt200x_init(struct dvb_frontend* fe)
         |            ^
>> drivers/media/dvb-frontends/nxt200x.c:519:12: warning: stack frame size (9656) exceeds limit (8192) in 'nxt200x_setup_frontend_parameters' [-Wframe-larger-than]
     519 | static int nxt200x_setup_frontend_parameters(struct dvb_frontend *fe)
         |            ^
   2 warnings generated.

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for DRM_I915_DEBUG_GEM
   Depends on [n]: HAS_IOMEM [=y] && DRM_I915 [=y] && EXPERT [=y] && DRM_I915_WERROR [=n]
   Selected by [y]:
   - DRM_I915_DEBUG [=y] && HAS_IOMEM [=y] && DRM_I915 [=y] && EXPERT [=y] && !COMPILE_TEST [=n]


vim +/cxd2841er_set_frontend_tc +3376 drivers/media/dvb-frontends/cxd2841er.c

a6dc60ff1209df Kozlov Sergey   2015-07-28  3375  
a6dc60ff1209df Kozlov Sergey   2015-07-28 @3376  static int cxd2841er_set_frontend_tc(struct dvb_frontend *fe)
a6dc60ff1209df Kozlov Sergey   2015-07-28  3377  {
a6dc60ff1209df Kozlov Sergey   2015-07-28  3378  	int ret = 0, timeout;
a6dc60ff1209df Kozlov Sergey   2015-07-28  3379  	enum fe_status status;
a6dc60ff1209df Kozlov Sergey   2015-07-28  3380  	struct cxd2841er_priv *priv = fe->demodulator_priv;
a6dc60ff1209df Kozlov Sergey   2015-07-28  3381  	struct dtv_frontend_properties *p = &fe->dtv_property_cache;
a6dc60ff1209df Kozlov Sergey   2015-07-28  3382  
3f3b48a0c6caba Abylay Ospan    2016-05-14  3383  	dev_dbg(&priv->i2c->dev, "%s() delivery_system=%d bandwidth_hz=%d\n",
3f3b48a0c6caba Abylay Ospan    2016-05-14  3384  		 __func__, p->delivery_system, p->bandwidth_hz);
763f857e40f371 Daniel Scheller 2017-04-09  3385  
763f857e40f371 Daniel Scheller 2017-04-09  3386  	if (priv->flags & CXD2841ER_EARLY_TUNE)
763f857e40f371 Daniel Scheller 2017-04-09  3387  		cxd2841er_tuner_set(fe);
763f857e40f371 Daniel Scheller 2017-04-09  3388  
bd2355b8efc684 Daniel Scheller 2017-07-11  3389  	/* deconfigure/put demod to sleep on delsys switch if active */
bd2355b8efc684 Daniel Scheller 2017-07-11  3390  	if (priv->state == STATE_ACTIVE_TC &&
bd2355b8efc684 Daniel Scheller 2017-07-11  3391  	    priv->system != p->delivery_system) {
bd2355b8efc684 Daniel Scheller 2017-07-11  3392  		dev_dbg(&priv->i2c->dev, "%s(): old_delsys=%d, new_delsys=%d -> sleep\n",
bd2355b8efc684 Daniel Scheller 2017-07-11  3393  			 __func__, priv->system, p->delivery_system);
bd2355b8efc684 Daniel Scheller 2017-07-11  3394  		cxd2841er_sleep_tc(fe);
bd2355b8efc684 Daniel Scheller 2017-07-11  3395  	}
bd2355b8efc684 Daniel Scheller 2017-07-11  3396  
a6dc60ff1209df Kozlov Sergey   2015-07-28  3397  	if (p->delivery_system == SYS_DVBT) {
a6dc60ff1209df Kozlov Sergey   2015-07-28  3398  		priv->system = SYS_DVBT;
a6dc60ff1209df Kozlov Sergey   2015-07-28  3399  		switch (priv->state) {
a6dc60ff1209df Kozlov Sergey   2015-07-28  3400  		case STATE_SLEEP_TC:
a6dc60ff1209df Kozlov Sergey   2015-07-28  3401  			ret = cxd2841er_sleep_tc_to_active_t(
a6dc60ff1209df Kozlov Sergey   2015-07-28  3402  				priv, p->bandwidth_hz);
a6dc60ff1209df Kozlov Sergey   2015-07-28  3403  			break;
a6dc60ff1209df Kozlov Sergey   2015-07-28  3404  		case STATE_ACTIVE_TC:
a6dc60ff1209df Kozlov Sergey   2015-07-28  3405  			ret = cxd2841er_retune_active(priv, p);
a6dc60ff1209df Kozlov Sergey   2015-07-28  3406  			break;
a6dc60ff1209df Kozlov Sergey   2015-07-28  3407  		default:
a6dc60ff1209df Kozlov Sergey   2015-07-28  3408  			dev_dbg(&priv->i2c->dev, "%s(): invalid state %d\n",
a6dc60ff1209df Kozlov Sergey   2015-07-28  3409  				__func__, priv->state);
a6dc60ff1209df Kozlov Sergey   2015-07-28  3410  			ret = -EINVAL;
a6dc60ff1209df Kozlov Sergey   2015-07-28  3411  		}
a6dc60ff1209df Kozlov Sergey   2015-07-28  3412  	} else if (p->delivery_system == SYS_DVBT2) {
a6dc60ff1209df Kozlov Sergey   2015-07-28  3413  		priv->system = SYS_DVBT2;
a6dc60ff1209df Kozlov Sergey   2015-07-28  3414  		cxd2841er_dvbt2_set_plp_config(priv,
a6dc60ff1209df Kozlov Sergey   2015-07-28  3415  			(int)(p->stream_id > 255), p->stream_id);
a6dc60ff1209df Kozlov Sergey   2015-07-28  3416  		cxd2841er_dvbt2_set_profile(priv, DVBT2_PROFILE_BASE);
a6dc60ff1209df Kozlov Sergey   2015-07-28  3417  		switch (priv->state) {
a6dc60ff1209df Kozlov Sergey   2015-07-28  3418  		case STATE_SLEEP_TC:
a6dc60ff1209df Kozlov Sergey   2015-07-28  3419  			ret = cxd2841er_sleep_tc_to_active_t2(priv,
a6dc60ff1209df Kozlov Sergey   2015-07-28  3420  				p->bandwidth_hz);
a6dc60ff1209df Kozlov Sergey   2015-07-28  3421  			break;
a6dc60ff1209df Kozlov Sergey   2015-07-28  3422  		case STATE_ACTIVE_TC:
a6dc60ff1209df Kozlov Sergey   2015-07-28  3423  			ret = cxd2841er_retune_active(priv, p);
a6dc60ff1209df Kozlov Sergey   2015-07-28  3424  			break;
a6dc60ff1209df Kozlov Sergey   2015-07-28  3425  		default:
a6dc60ff1209df Kozlov Sergey   2015-07-28  3426  			dev_dbg(&priv->i2c->dev, "%s(): invalid state %d\n",
a6dc60ff1209df Kozlov Sergey   2015-07-28  3427  				__func__, priv->state);
a6dc60ff1209df Kozlov Sergey   2015-07-28  3428  			ret = -EINVAL;
a6dc60ff1209df Kozlov Sergey   2015-07-28  3429  		}
83808c23e51a61 Abylay Ospan    2016-03-22  3430  	} else if (p->delivery_system == SYS_ISDBT) {
83808c23e51a61 Abylay Ospan    2016-03-22  3431  		priv->system = SYS_ISDBT;
83808c23e51a61 Abylay Ospan    2016-03-22  3432  		switch (priv->state) {
83808c23e51a61 Abylay Ospan    2016-03-22  3433  		case STATE_SLEEP_TC:
83808c23e51a61 Abylay Ospan    2016-03-22  3434  			ret = cxd2841er_sleep_tc_to_active_i(
83808c23e51a61 Abylay Ospan    2016-03-22  3435  					priv, p->bandwidth_hz);
83808c23e51a61 Abylay Ospan    2016-03-22  3436  			break;
83808c23e51a61 Abylay Ospan    2016-03-22  3437  		case STATE_ACTIVE_TC:
83808c23e51a61 Abylay Ospan    2016-03-22  3438  			ret = cxd2841er_retune_active(priv, p);
83808c23e51a61 Abylay Ospan    2016-03-22  3439  			break;
83808c23e51a61 Abylay Ospan    2016-03-22  3440  		default:
83808c23e51a61 Abylay Ospan    2016-03-22  3441  			dev_dbg(&priv->i2c->dev, "%s(): invalid state %d\n",
83808c23e51a61 Abylay Ospan    2016-03-22  3442  					__func__, priv->state);
83808c23e51a61 Abylay Ospan    2016-03-22  3443  			ret = -EINVAL;
83808c23e51a61 Abylay Ospan    2016-03-22  3444  		}
a6dc60ff1209df Kozlov Sergey   2015-07-28  3445  	} else if (p->delivery_system == SYS_DVBC_ANNEX_A ||
a6dc60ff1209df Kozlov Sergey   2015-07-28  3446  			p->delivery_system == SYS_DVBC_ANNEX_C) {
a6dc60ff1209df Kozlov Sergey   2015-07-28  3447  		priv->system = SYS_DVBC_ANNEX_A;
3f3b48a0c6caba Abylay Ospan    2016-05-14  3448  		/* correct bandwidth */
3f3b48a0c6caba Abylay Ospan    2016-05-14  3449  		if (p->bandwidth_hz != 6000000 &&
3f3b48a0c6caba Abylay Ospan    2016-05-14  3450  				p->bandwidth_hz != 7000000 &&
3f3b48a0c6caba Abylay Ospan    2016-05-14  3451  				p->bandwidth_hz != 8000000) {
3f3b48a0c6caba Abylay Ospan    2016-05-14  3452  			p->bandwidth_hz = 8000000;
3f3b48a0c6caba Abylay Ospan    2016-05-14  3453  			dev_dbg(&priv->i2c->dev, "%s(): forcing bandwidth to %d\n",
3f3b48a0c6caba Abylay Ospan    2016-05-14  3454  					__func__, p->bandwidth_hz);
3f3b48a0c6caba Abylay Ospan    2016-05-14  3455  		}
3f3b48a0c6caba Abylay Ospan    2016-05-14  3456  
a6dc60ff1209df Kozlov Sergey   2015-07-28  3457  		switch (priv->state) {
a6dc60ff1209df Kozlov Sergey   2015-07-28  3458  		case STATE_SLEEP_TC:
a6dc60ff1209df Kozlov Sergey   2015-07-28  3459  			ret = cxd2841er_sleep_tc_to_active_c(
a6dc60ff1209df Kozlov Sergey   2015-07-28  3460  				priv, p->bandwidth_hz);
a6dc60ff1209df Kozlov Sergey   2015-07-28  3461  			break;
a6dc60ff1209df Kozlov Sergey   2015-07-28  3462  		case STATE_ACTIVE_TC:
a6dc60ff1209df Kozlov Sergey   2015-07-28  3463  			ret = cxd2841er_retune_active(priv, p);
a6dc60ff1209df Kozlov Sergey   2015-07-28  3464  			break;
a6dc60ff1209df Kozlov Sergey   2015-07-28  3465  		default:
a6dc60ff1209df Kozlov Sergey   2015-07-28  3466  			dev_dbg(&priv->i2c->dev, "%s(): invalid state %d\n",
a6dc60ff1209df Kozlov Sergey   2015-07-28  3467  				__func__, priv->state);
a6dc60ff1209df Kozlov Sergey   2015-07-28  3468  			ret = -EINVAL;
a6dc60ff1209df Kozlov Sergey   2015-07-28  3469  		}
a6dc60ff1209df Kozlov Sergey   2015-07-28  3470  	} else {
a6dc60ff1209df Kozlov Sergey   2015-07-28  3471  		dev_dbg(&priv->i2c->dev,
a6dc60ff1209df Kozlov Sergey   2015-07-28  3472  			"%s(): invalid delivery system %d\n",
a6dc60ff1209df Kozlov Sergey   2015-07-28  3473  			__func__, p->delivery_system);
a6dc60ff1209df Kozlov Sergey   2015-07-28  3474  		ret = -EINVAL;
a6dc60ff1209df Kozlov Sergey   2015-07-28  3475  	}
a6dc60ff1209df Kozlov Sergey   2015-07-28  3476  	if (ret)
a6dc60ff1209df Kozlov Sergey   2015-07-28  3477  		goto done;
c7518d13f70e62 Daniel Scheller 2017-04-09  3478  
763f857e40f371 Daniel Scheller 2017-04-09  3479  	if (!(priv->flags & CXD2841ER_EARLY_TUNE))
c7518d13f70e62 Daniel Scheller 2017-04-09  3480  		cxd2841er_tuner_set(fe);
c7518d13f70e62 Daniel Scheller 2017-04-09  3481  
a6dc60ff1209df Kozlov Sergey   2015-07-28  3482  	cxd2841er_tune_done(priv);
e3943aa6d8023b Daniel Scheller 2017-04-09  3483  
e3943aa6d8023b Daniel Scheller 2017-04-09  3484  	if (priv->flags & CXD2841ER_NO_WAIT_LOCK)
e3943aa6d8023b Daniel Scheller 2017-04-09  3485  		goto done;
e3943aa6d8023b Daniel Scheller 2017-04-09  3486  
a6dc60ff1209df Kozlov Sergey   2015-07-28  3487  	timeout = 2500;
a6dc60ff1209df Kozlov Sergey   2015-07-28  3488  	while (timeout > 0) {
a6dc60ff1209df Kozlov Sergey   2015-07-28  3489  		ret = cxd2841er_read_status_tc(fe, &status);
a6dc60ff1209df Kozlov Sergey   2015-07-28  3490  		if (ret)
a6dc60ff1209df Kozlov Sergey   2015-07-28  3491  			goto done;
a6dc60ff1209df Kozlov Sergey   2015-07-28  3492  		if (status & FE_HAS_LOCK)
a6dc60ff1209df Kozlov Sergey   2015-07-28  3493  			break;
a6dc60ff1209df Kozlov Sergey   2015-07-28  3494  		msleep(20);
a6dc60ff1209df Kozlov Sergey   2015-07-28  3495  		timeout -= 20;
a6dc60ff1209df Kozlov Sergey   2015-07-28  3496  	}
a6dc60ff1209df Kozlov Sergey   2015-07-28  3497  	if (timeout < 0)
a6dc60ff1209df Kozlov Sergey   2015-07-28  3498  		dev_dbg(&priv->i2c->dev,
a6dc60ff1209df Kozlov Sergey   2015-07-28  3499  			"%s(): LOCK wait timeout\n", __func__);
a6dc60ff1209df Kozlov Sergey   2015-07-28  3500  done:
a6dc60ff1209df Kozlov Sergey   2015-07-28  3501  	return ret;
a6dc60ff1209df Kozlov Sergey   2015-07-28  3502  }
a6dc60ff1209df Kozlov Sergey   2015-07-28  3503  

:::::: The code at line 3376 was first introduced by commit
:::::: a6dc60ff1209df29ee4668024e93d31f31421932 [media] cxd2841er: Sony CXD2841ER DVB-S/S2/T/T2/C demodulator driver

:::::: TO: Kozlov Sergey <serjk@netup.ru>
:::::: CC: Mauro Carvalho Chehab <mchehab@osg.samsung.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

