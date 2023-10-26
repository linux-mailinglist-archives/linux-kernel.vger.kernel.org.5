Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 515997D79FE
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 03:13:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbjJZBNh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 21:13:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjJZBNe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 21:13:34 -0400
Received: from wxsgout04.xfusion.com (wxsgout03.xfusion.com [36.139.52.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94A2AA4;
        Wed, 25 Oct 2023 18:13:31 -0700 (PDT)
Received: from wuxshcsitd00600.xfusion.com (unknown [10.32.133.213])
        by wxsgout04.xfusion.com (SkyGuard) with ESMTPS id 4SG75F2FpWz9xn2W;
        Thu, 26 Oct 2023 09:10:25 +0800 (CST)
Received: from localhost (10.82.147.3) by wuxshcsitd00600.xfusion.com
 (10.32.133.213) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 26 Oct
 2023 09:12:54 +0800
Date:   Thu, 26 Oct 2023 09:12:54 +0800
From:   Wang Jinchao <wangjinchao@xfusion.com>
To:     Daniel Jordan <daniel.m.jordan@oracle.com>
CC:     Steffen Klassert <steffen.klassert@secunet.com>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <stone.xulei@xfusion.com>
Subject: Re: [RFC/REFACT] Refactoring and significantly reducing code
 complexity
Message-ID: <ZTm9FtrdLXekn5Rm@fedora>
References: <ZRU/EjubEH/5QLlG@fedora>
 <x7jww3a7lebhjbwfxwabtypqzq2s752nh6xo4vpchuz2dnsefo@45aftcl4wlyx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <x7jww3a7lebhjbwfxwabtypqzq2s752nh6xo4vpchuz2dnsefo@45aftcl4wlyx>
X-Originating-IP: [10.82.147.3]
X-ClientProxiedBy: wuxshcsitd00602.xfusion.com (10.32.132.250) To
 wuxshcsitd00600.xfusion.com (10.32.133.213)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 25, 2023 at 02:12:31PM -0400, Daniel Jordan wrote:
> On Thu, Sep 28, 2023 at 04:53:38PM +0800, Wang Jinchao wrote:
> > -/**
> > - * struct parallel_data - Internal control structure, covers everything
> > - * that depends on the cpumask in use.
> > - *
> > - * @ps: padata_shell object.
> > - * @reorder_list: percpu reorder lists
> > - * @squeue: percpu padata queues used for serialuzation.
> > - * @refcnt: Number of objects holding a reference on this parallel_data.
> > - * @seq_nr: Sequence number of the parallelized data object.
> > - * @processed: Number of already processed objects.
> > - * @cpu: Next CPU to be processed.
> > - * @cpumask: The cpumasks in use for parallel and serial workers.
> > - * @reorder_work: work struct for reordering.
> > - * @lock: Reorder lock.
> > - */
> > -struct parallel_data {
> > -	struct padata_shell		*ps;
> > -	struct padata_list		__percpu *reorder_list;
> > -	struct padata_serial_queue	__percpu *squeue;
> > -	refcount_t			refcnt;
> > -	unsigned int			seq_nr;
> > -	unsigned int			processed;
> > -	int				cpu;
> > -	struct padata_cpumask		cpumask;
> > -	struct work_struct		reorder_work;
> > -	spinlock_t                      ____cacheline_aligned lock;
> > -};
> 
> reorder_list used to serialize one sequence of objects per padata_shell,
> but now serial_wq serializes all sequences of objects in one list of
> work_structs.  That works in theory, since a total order can maintain
> each sequence's order, but it's possible (not sure yet, need to think
> more) that this could lead to deadlocks or other issues in odd cases
> such as the one that padata_shell was introduced for in bbefa1dd6a6d
> ("crypto: pcrypt - Avoid deadlock by using per-instance padata queues").
> 
Yes, you are correct. This version is not only ordered at the padata_shell
level but at the instance level, which indeed doesn't align with the design.
Apart from potential deadlocks, it may also cause a padata_shell_B that
should have completed earlier to be blocked by an unrelated padata_shell_B.
I will address this issue in subsequent patches.
