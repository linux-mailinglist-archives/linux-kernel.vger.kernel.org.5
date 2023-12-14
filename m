Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE4F781253E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 03:26:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235321AbjLNC01 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 21:26:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234093AbjLNC0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 21:26:25 -0500
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5710510A
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 18:26:30 -0800 (PST)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20231214022628epoutp019389bd0c78a9e617887e5871dedb6e7a~gkaL3rsSw0940409404epoutp01M
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 02:26:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20231214022628epoutp019389bd0c78a9e617887e5871dedb6e7a~gkaL3rsSw0940409404epoutp01M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1702520788;
        bh=y6txrFueQCif9XjUGoARu28dTO/JZ5iJPn+GmcpZJhw=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=QXEOCreq8fYqaDKbzWspz4xA3khS8OuMYROCCDmZH3WpnteUCAzQufs2NNquj2Tz/
         YihuOF4dCJwjeRwI+St3JNNO1OJcxqrch6/CFqsPcApUc3ggCL9o7vHw+nv2AwKmI+
         y4Z0xst7DBmEWN5mOLzZZiQf+Wdu638urqDx/TB0=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20231214022627epcas2p370352be2f7cfaedecabcfd2c61beb777~gkaLTZPpt2584825848epcas2p3J;
        Thu, 14 Dec 2023 02:26:27 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.98]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4SrGSL6wCtz4x9QB; Thu, 14 Dec
        2023 02:26:26 +0000 (GMT)
X-AuditID: b6c32a47-9a3ff70000002726-fc-657a67d23d78
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        7B.76.10022.2D76A756; Thu, 14 Dec 2023 11:26:26 +0900 (KST)
Mime-Version: 1.0
Subject: RE:(2) [PATCH v2] f2fs: New victim selection for GC
Reply-To: yonggil.song@samsung.com
Sender: Yonggil Song <yonggil.song@samsung.com>
From:   Yonggil Song <yonggil.song@samsung.com>
To:     Jaegeuk Kim <jaegeuk@kernel.org>
CC:     "chao@kernel.org" <chao@kernel.org>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Seokhwan Kim <sukka.kim@samsung.com>,
        Daejun Park <daejun7.park@samsung.com>,
        Siwoo Jung <siu.jung@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <ZXeRkAoQTtTpf1dg@google.com>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20231214022626epcms2p7e4a2a87bdaab09c7a4babb71780133c5@epcms2p7>
Date:   Thu, 14 Dec 2023 11:26:26 +0900
X-CMS-MailID: 20231214022626epcms2p7e4a2a87bdaab09c7a4babb71780133c5
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
X-CPGSPASS: Y
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpkk+LIzCtJLcpLzFFi42LZdljTXPdSelWqwaqtZhanp55lsnh5SNNi
        1YNwiyfrZzFbXFrkbnF51xw2i/MTXzNZrOqYy+jA4bFpVSebx+4Fn5k8+rasYvT4vEkugCUq
        2yYjNTEltUghNS85PyUzL91WyTs43jne1MzAUNfQ0sJcSSEvMTfVVsnFJ0DXLTMH6AYlhbLE
        nFKgUEBicbGSvp1NUX5pSapCRn5xia1SakFKToF5gV5xYm5xaV66Xl5qiZWhgYGRKVBhQnZG
        96Z1rAUvXCrOnvvI3sC4w7iLkZNDQsBEonH/ceYuRi4OIYEdjBL/3m0Bcjg4eAUEJf7uEAYx
        hQVsJD5vVwMpFxJQkrh2oJcFxBYW0JfYvHgZO4jNJqAr8XfDcjBbREBF4tCiy2A2s8AmJolL
        h9UhVvFKzGh/ygJhS0tsX76VEcTmFNCSOLjjLTtEXEPix7JeZghbVOLmapi4qMT7Y/MZIWwR
        idZ7Z6FqBCUe/NwNFZeUWHToPBOEnS/xd8V1Ngi7RmJrQxtUXF/iWsdGsBt4BXwlGqa8BJvP
        IqAqcfbsa6iZLhKXJkHsYhaQl9j+dg44RJgFNCXW79IHMSUElCWO3GKBqOCT6Dj8lx3mw4aN
        v7Gyd8x7AnWBmsTmTZtZJzAqz0IE8ywku2Yh7FrAyLyKUSy1oDg3PbXYqMAYHrPJ+bmbGMFp
        Uct9B+OMtx/0DjEycTAeYpTgYFYS4T25ozxViDclsbIqtSg/vqg0J7X4EKMp0JcTmaVEk/OB
        iTmvJN7QxNLAxMzM0NzI1MBcSZz3XuvcFCGB9MSS1OzU1ILUIpg+Jg5OqQYmyZfN57ebFG/M
        +d5/pnhen8U32X2mGy0TQutLdxq6TDZj+r+HYe+TnXHPGdyM/r07aqA2SazYW+rcoTyHii/+
        px0Py2Re0JSbJW678uCk549/Oswtr1x9bsuUD7G1flaf2xP3l6t7vuDQTO6X/5PtfnGjR6+V
        duWniLzXG69XzN2Z56G+dUe81oeKiu2V+xyzP61LjJrxWLrwmqzS9GKxzrcsBq1sTkKXlU4+
        MPlnw1kXE2TbedOwZ1/+t2qH24weDN1Oi5ybpVc80fwp8F3xVPZbfRax89V2kzcWevdVb57x
        7Gmqveub3eGlkwTiGJW21W4yXPZIpPqsY61A9Kn7xW1Cqy02KaycMr+z568SS3FGoqEWc1Fx
        IgD4kfZJFAQAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231208090444epcms2p33884216391931d04c1771dfb51a08a44
References: <ZXeRkAoQTtTpf1dg@google.com>
        <20231208090444epcms2p33884216391931d04c1771dfb51a08a44@epcms2p3>
        <CGME20231208090444epcms2p33884216391931d04c1771dfb51a08a44@epcms2p7>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On 12/08, Yonggil Song wrote:
> > Overview
> > ========
> > 
> > This patch introduces a new way to preference data sections when selecting
> > GC victims. Migration of data blocks causes invalidation of node blocks.
> > Therefore, in situations where GC is frequent, selecting data blocks as
> > victims can reduce unnecessary block migration by invalidating node blocks.
> > For exceptional situations where free sections are insufficient, node blocks
> > are selected as victims instead of data blocks to get extra free sections.
> > 
> > Problem
> > =======
> > 
> > If the total amount of nodes is larger than the size of one section, nodes
> > occupy multiple sections, and node victims are often selected because the
> > gc cost is lowered by data block migration in GC. Since moving the data
> > section causes frequent node victim selection, victim threshing occurs in
> > the node section. This results in an increase in WAF.
> > 
> > Experiment
> > ==========
> > 
> > Test environment is as follows.
> > 
> >         System info
> >           - 3.6GHz, 16 core CPU
> >           - 36GiB Memory
> >         Device info
> >           - a conventional null_blk with 228MiB
> >           - a sequential null_blk with 4068 zones of 8MiB
> >         Format
> >           - mkfs.f2fs <conv null_blk> -c <seq null_blk> -m -Z 8 -o 3.89
> >         Mount
> >           - mount <conv null_blk> <mount point>
> >         Fio script
> > 	  - fio --rw=randwrite --bs=4k --ba=4k --filesize=31187m --norandommap --overwrite=1 --name=job1 --filename=./mnt/sustain --io_size=128g
> > 	WAF calculation
> > 	  - (IOs on conv. null_blk + IOs on seq. null_blk) / random write IOs
> > 
> > Conclusion
> > ==========
> > 
> > This experiment showed that the WAF was reduced by 29% (18.75 -> 13.3) when
> > the data section was selected first when selecting GC victims. This was
> > achieved by reducing the migration of the node blocks by 69.4%
> > (253,131,743 blks -> 77,463,278 blks). It is possible to achieve low WAF
> > performance with the GC victim selection method in environments where the
> > section size is relatively small.
> > 
> > Signed-off-by: Yonggil Song <yonggil.song@samsung.com>
> > ---
> >  fs/f2fs/f2fs.h |  1 +
> >  fs/f2fs/gc.c   | 98 ++++++++++++++++++++++++++++++++++++++------------
> >  2 files changed, 77 insertions(+), 22 deletions(-)
> > 
> > diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> > index 9043cedfa12b..578d57f6022f 100644
> > --- a/fs/f2fs/f2fs.h
> > +++ b/fs/f2fs/f2fs.h
> > @@ -1649,6 +1649,7 @@ struct f2fs_sb_info {
> >  	struct f2fs_mount_info mount_opt;	/* mount options */
> >  
> >  	/* for cleaning operations */
> > +	bool need_node_clean;			/* need to clean dirty nodes */
> >  	struct f2fs_rwsem gc_lock;		/*
> >  						 * semaphore for GC, avoid
> >  						 * race between GC and GC or CP
> > diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> > index f550cdeaa663..682dcf0de59e 100644
> > --- a/fs/f2fs/gc.c
> > +++ b/fs/f2fs/gc.c
> > @@ -368,6 +368,14 @@ static inline unsigned int get_gc_cost(struct f2fs_sb_info *sbi,
> >  	if (p->alloc_mode == SSR)
> >  		return get_seg_entry(sbi, segno)->ckpt_valid_blocks;
> >  
> > +	/*
> > +	 * If we don't need to clean dirty nodes,
> > +	 * we just skip node victims.
> > +	 */
> > +	if (IS_NODESEG(get_seg_entry(sbi, segno)->type) &&
> > +		!sbi->need_node_clean)
> > +		return get_max_cost(sbi, p);
> 
> How about differentiating the gc cost between data vs. node by adding some
> weights? By default, data is preferred, while node is better in the worst case?
> 

Okay, I will work on v3 with your comments

> > +
> >  	/* alloc_mode == LFS */
> >  	if (p->gc_mode == GC_GREEDY)
> >  		return get_valid_blocks(sbi, segno, true);
> > @@ -557,6 +565,14 @@ static void atgc_lookup_victim(struct f2fs_sb_info *sbi,
> >  	if (ve->mtime >= max_mtime || ve->mtime < min_mtime)
> >  		goto skip;
> >  
> > +	/*
> > +	 * If we don't need to clean dirty nodes,
> > +	 * we just skip node victims.
> > +	 */
> > +	if (IS_NODESEG(get_seg_entry(sbi, ve->segno)->type) &&
> > +	    !sbi->need_node_clean)
> > +		goto skip;
> > +
> >  	/* age = 10000 * x% * 60 */
> >  	age = div64_u64(accu * (max_mtime - ve->mtime), total_time) *
> >  								age_weight;
> > @@ -913,7 +929,21 @@ int f2fs_get_victim(struct f2fs_sb_info *sbi, unsigned int *result,
> >  		goto retry;
> >  	}
> >  
> > +
> >  	if (p.min_segno != NULL_SEGNO) {
> > +		if (sbi->need_node_clean &&
> > +		    IS_DATASEG(get_seg_entry(sbi, p.min_segno)->type)) {
> > +			 /*
> > +			  * we need to clean node sections.
> > +			  * but, data victim cost is the lowest.
> > +			  * if free sections are enough, stop cleaning node victim.
> > +			  * if not, it goes on by GCing data victims.
> > +			  */
> > +			if (has_enough_free_secs(sbi, prefree_segments(sbi), 0)) {
> > +				p.min_segno = NULL_SEGNO;
> > +				goto out;
> > +			}
> > +		}
> >  got_it:
> >  		*result = (p.min_segno / p.ofs_unit) * p.ofs_unit;
> >  got_result:
> > @@ -1830,8 +1860,27 @@ int f2fs_gc(struct f2fs_sb_info *sbi, struct f2fs_gc_control *gc_control)
> >  		goto stop;
> >  	}
> >  
> > +	__get_secs_required(sbi, NULL, &upper_secs, NULL);
> > +
> > +	/*
> > +	 * Write checkpoint to reclaim prefree segments.
> > +	 * We need more three extra sections for writer's data/node/dentry.
> > +	 */
> > +	if (free_sections(sbi) <= upper_secs + NR_GC_CHECKPOINT_SECS) {
> > +		sbi->need_node_clean = true;
> > +
> > +		if (prefree_segments(sbi)) {
> > +			stat_inc_cp_call_count(sbi, TOTAL_CALL);
> > +			ret = f2fs_write_checkpoint(sbi, &cpc);
> > +			if (ret)
> > +				goto stop;
> > +			/* Reset due to checkpoint */
> > +			sec_freed = 0;
> > +		}
> > +	}
> > +
> >  	/* Let's run FG_GC, if we don't have enough space. */
> > -	if (has_not_enough_free_secs(sbi, 0, 0)) {
> > +	if (gc_type == BG_GC && has_not_enough_free_secs(sbi, 0, 0)) {
> >  		gc_type = FG_GC;
> >  
> >  		/*
> > @@ -1858,10 +1907,22 @@ int f2fs_gc(struct f2fs_sb_info *sbi, struct f2fs_gc_control *gc_control)
> >  	ret = __get_victim(sbi, &segno, gc_type);
> >  	if (ret) {
> >  		/* allow to search victim from sections has pinned data */
> > -		if (ret == -ENODATA && gc_type == FG_GC &&
> > -				f2fs_pinned_section_exists(DIRTY_I(sbi))) {
> > -			f2fs_unpin_all_sections(sbi, false);
> > -			goto retry;
> > +		if (ret == -ENODATA && gc_type == FG_GC) {
> > +			if (f2fs_pinned_section_exists(DIRTY_I(sbi))) {
> > +				f2fs_unpin_all_sections(sbi, false);
> > +				goto retry;
> > +			}
> > +			/*
> > +			 * If we have no more data victims, let's start to
> > +			 * clean dirty nodes.
> > +			 */
> > +			if (!sbi->need_node_clean) {
> > +				sbi->need_node_clean = true;
> > +				goto retry;
> > +			}
> > +			/* node cleaning is over */
> > +			else if (sbi->need_node_clean)
> > +				goto stop;
> >  		}
> >  		goto stop;
> >  	}
> > @@ -1882,7 +1943,13 @@ int f2fs_gc(struct f2fs_sb_info *sbi, struct f2fs_gc_control *gc_control)
> >  			if (!gc_control->no_bg_gc &&
> >  			    total_sec_freed < gc_control->nr_free_secs)
> >  				goto go_gc_more;
> > -			goto stop;
> > +			/*
> > +			 * If the need_node_clean flag is set
> > +			 * even though there are enough free
> > +			 * sections, node cleaning will continue.
> > +			 */
> > +			if (!sbi->need_node_clean)
> > +				goto stop;
> >  		}
> >  		if (sbi->skipped_gc_rwsem)
> >  			skipped_round++;
> > @@ -1897,21 +1964,6 @@ int f2fs_gc(struct f2fs_sb_info *sbi, struct f2fs_gc_control *gc_control)
> >  		goto stop;
> >  	}
> >  
> > -	__get_secs_required(sbi, NULL, &upper_secs, NULL);
> > -
> > -	/*
> > -	 * Write checkpoint to reclaim prefree segments.
> > -	 * We need more three extra sections for writer's data/node/dentry.
> > -	 */
> > -	if (free_sections(sbi) <= upper_secs + NR_GC_CHECKPOINT_SECS &&
> > -				prefree_segments(sbi)) {
> > -		stat_inc_cp_call_count(sbi, TOTAL_CALL);
> > -		ret = f2fs_write_checkpoint(sbi, &cpc);
> > -		if (ret)
> > -			goto stop;
> > -		/* Reset due to checkpoint */
> > -		sec_freed = 0;
> > -	}
> >  go_gc_more:
> >  	segno = NULL_SEGNO;
> >  	goto gc_more;
> > @@ -1920,8 +1972,10 @@ int f2fs_gc(struct f2fs_sb_info *sbi, struct f2fs_gc_control *gc_control)
> >  	SIT_I(sbi)->last_victim[ALLOC_NEXT] = 0;
> >  	SIT_I(sbi)->last_victim[FLUSH_DEVICE] = gc_control->victim_segno;
> >  
> > -	if (gc_type == FG_GC)
> > +	if (gc_type == FG_GC) {
> >  		f2fs_unpin_all_sections(sbi, true);
> > +		sbi->need_node_clean = false;
> > +	}
> >  
> >  	trace_f2fs_gc_end(sbi->sb, ret, total_freed, total_sec_freed,
> >  				get_pages(sbi, F2FS_DIRTY_NODES),
> > -- 
> > 2.34.1
