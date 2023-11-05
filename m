Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 747787E1370
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Nov 2023 13:58:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbjKEM6q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 07:58:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjKEM6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 07:58:45 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34D83DE
        for <linux-kernel@vger.kernel.org>; Sun,  5 Nov 2023 04:57:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699189075;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=f1HgvMzkgTZ9Ert5Ty0eeOqI1iS7dAZC/TkQplw2tFA=;
        b=BrRrMmgGJm9kmv2Vap+qBvIVX43Lcn1D+vJ4uqIl/fUv0tUyohxYgIoqptyzaGmBxESMBK
        m+7Ae0Qq2pGGrQ2nYWemE31N/hr+PS2UzOBVZOwng/ATPRDcZ/f3o4YU1aJEkolqYoLoJ/
        ZOjy2+L8B5jiy5uMPliOlrKia7E5iEU=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-602-ET_y1B-sOGWPFLNnWiNa3A-1; Sun, 05 Nov 2023 07:57:52 -0500
X-MC-Unique: ET_y1B-sOGWPFLNnWiNa3A-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-9ddae43f3f7so97284866b.3
        for <linux-kernel@vger.kernel.org>; Sun, 05 Nov 2023 04:57:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699189070; x=1699793870;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f1HgvMzkgTZ9Ert5Ty0eeOqI1iS7dAZC/TkQplw2tFA=;
        b=a//y38UBjcO6Jq1A7VgsXjxrDaOdHIuNJl1W8e0TOX8FFp1AE/whKMPxUWy2e4r5WI
         +wFysD3CNt8U1elKj5t+uaRmrTgef6Kor9Re16ZZAcAg9ZMRWHlY1Mo1kxVG9R0mrQlU
         thzYDFZpfEKgFC66UbNlDTgiml+QropR5BbfiU/BhgZSPX7gpiindbR2xBQfgIEmDPCW
         qe0uyEfIxA4z/ZFKihzqypMCFpsCE8rVuYYTML7I4LPbrd2Wc4qZyan1FbObxMko6goo
         tTVRfIEWUcfK35YLiy94wrsf1qU7vx8P5F1CRGaoxmuraQG4aTqZQGIC+JWQmFiJWr8Z
         F/bA==
X-Gm-Message-State: AOJu0Yyzx/Ud7zrl61llrLfsBGF8bmo6oO/AVHGrHf3YqKlbtMEm4tkt
        rEKtol8FRsRlyMmBcoWof4eNmxQJhI7KGmxjAvzGPXu8mGcJ9kTu9H+fnwTCV+jbnGab3q+H+Hn
        E+u1VDVgWksLNnsWK4xoXiP4YvcIAw5C/
X-Received: by 2002:a17:907:1c17:b0:9be:fc60:32d9 with SMTP id nc23-20020a1709071c1700b009befc6032d9mr11171524ejc.47.1699189070723;
        Sun, 05 Nov 2023 04:57:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFln3jJBrFzRCKbbKrPWhGY0Su+bxv92NB8RcPpKgo0QzviSwUqwyL999GOWq2Mnh0i9a9wQA==
X-Received: by 2002:a17:907:1c17:b0:9be:fc60:32d9 with SMTP id nc23-20020a1709071c1700b009befc6032d9mr11171513ejc.47.1699189070385;
        Sun, 05 Nov 2023 04:57:50 -0800 (PST)
Received: from redhat.com ([2.55.35.234])
        by smtp.gmail.com with ESMTPSA id gs10-20020a170906f18a00b009b65b2be80bsm2990280ejb.76.2023.11.05.04.57.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Nov 2023 04:57:49 -0800 (PST)
Date:   Sun, 5 Nov 2023 07:57:44 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     kernel test robot <lkp@intel.com>
Cc:     Shannon Nelson <shannon.nelson@amd.com>,
        oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: drivers/vdpa/pds/debugfs.c:269:49: warning: '%02d' directive
 output may be truncated writing between 2 and 11 bytes into a region of size
 6
Message-ID: <20231105075350-mutt-send-email-mst@kernel.org>
References: <202311040109.RfgJoE7L-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202311040109.RfgJoE7L-lkp@intel.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 04, 2023 at 01:36:05AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   8f6f76a6a29f36d2f3e4510d0bde5046672f6924
> commit: 9a8864d2a8dc5c49acd66284fd382871d99b5db8 pds_vdpa: pds_vdps.rst and Kconfig
> date:   4 months ago
> config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20231104/202311040109.RfgJoE7L-lkp@intel.com/config)
> compiler: alpha-linux-gcc (GCC) 13.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231104/202311040109.RfgJoE7L-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202311040109.RfgJoE7L-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
>    drivers/vdpa/pds/debugfs.c: In function 'pds_vdpa_debugfs_add_vdpadev':
> >> drivers/vdpa/pds/debugfs.c:269:49: warning: '%02d' directive output may be truncated writing between 2 and 11 bytes into a region of size 6 [-Wformat-truncation=]
>      269 |                 snprintf(name, sizeof(name), "vq%02d", i);
>          |                                                 ^~~~
>    drivers/vdpa/pds/debugfs.c:269:46: note: directive argument in the range [-2147483641, 254]
>      269 |                 snprintf(name, sizeof(name), "vq%02d", i);
>          |                                              ^~~~~~~~
>    drivers/vdpa/pds/debugfs.c:269:17: note: 'snprintf' output between 5 and 14 bytes into a destination of size 8
>      269 |                 snprintf(name, sizeof(name), "vq%02d", i);
>          |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> 
> vim +269 drivers/vdpa/pds/debugfs.c

> 151cc834f3ddafe Shannon Nelson 2023-05-19  259  
> 151cc834f3ddafe Shannon Nelson 2023-05-19  260  void pds_vdpa_debugfs_add_vdpadev(struct pds_vdpa_aux *vdpa_aux)
> 151cc834f3ddafe Shannon Nelson 2023-05-19  261  {
> 151cc834f3ddafe Shannon Nelson 2023-05-19  262  	int i;
> 151cc834f3ddafe Shannon Nelson 2023-05-19  263  
> 151cc834f3ddafe Shannon Nelson 2023-05-19  264  	debugfs_create_file("config", 0400, vdpa_aux->dentry, vdpa_aux->pdsv, &config_fops);
> 151cc834f3ddafe Shannon Nelson 2023-05-19  265  
> 151cc834f3ddafe Shannon Nelson 2023-05-19  266  	for (i = 0; i < vdpa_aux->pdsv->num_vqs; i++) {
> 151cc834f3ddafe Shannon Nelson 2023-05-19  267  		char name[8];
> 151cc834f3ddafe Shannon Nelson 2023-05-19  268  
> 151cc834f3ddafe Shannon Nelson 2023-05-19 @269  		snprintf(name, sizeof(name), "vq%02d", i);
> 151cc834f3ddafe Shannon Nelson 2023-05-19  270  		debugfs_create_file(name, 0400, vdpa_aux->dentry,
> 151cc834f3ddafe Shannon Nelson 2023-05-19  271  				    &vdpa_aux->pdsv->vqs[i], &vq_fops);
> 151cc834f3ddafe Shannon Nelson 2023-05-19  272  	}
> 151cc834f3ddafe Shannon Nelson 2023-05-19  273  }
> 151cc834f3ddafe Shannon Nelson 2023-05-19  274  


So gcc can't figure out that i is positive in this loop :(

Let's make it unsigned I guess? Should calm it down.

Shannon could you send a patch please?

> 
> :::::: The code at line 269 was first introduced by commit
> :::::: 151cc834f3ddafec869269fe48036460d920d08a pds_vdpa: add support for vdpa and vdpamgmt interfaces
> 
> :::::: TO: Shannon Nelson <shannon.nelson@amd.com>
> :::::: CC: Michael S. Tsirkin <mst@redhat.com>
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

