Return-Path: <linux-kernel+bounces-11736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E5BB681EAFF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 01:33:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E34C0B22105
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 00:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB4501C3E;
	Wed, 27 Dec 2023 00:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="qWaKDCAL"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1041845
	for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 00:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20231227003315epoutp035925e9959e2898aeeabf5eb724da081d~kiQCxSlHB0664806648epoutp03Q
	for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 00:33:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20231227003315epoutp035925e9959e2898aeeabf5eb724da081d~kiQCxSlHB0664806648epoutp03Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1703637195;
	bh=skT1wjTpenesfQzwP/I9fGriw/DrFyBELXzGEDrraek=;
	h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
	b=qWaKDCAL3lOz9XVs6ilTiYkqj3u4wR1dLXafxj2H6Q/JDxG9+J/5uZckiy+MR+Yyh
	 hX5NWX+nHXWI6FBSw3VvZD9BsGZ7zaVEWACr1nFHWlTKW0OHijEyV7577/Ay9NcnQZ
	 I8g6mIoTpAqHRLJQu/oQUqfmqiLT/ItPxlXM1Fz8=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas2p4.samsung.com (KnoxPortal) with ESMTP id
	20231227003314epcas2p487991860e58669b8ab0fc4fb43ae712f~kiQCVWHb52056320563epcas2p4N;
	Wed, 27 Dec 2023 00:33:14 +0000 (GMT)
Received: from epsmgec2p1.samsung.com (unknown [182.195.36.91]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4T0CKk0N18z4x9QB; Wed, 27 Dec
	2023 00:33:14 +0000 (GMT)
X-AuditID: b6c32a43-721fd700000021c8-12-658b70c95cf5
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
	epsmgec2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
	2D.B3.08648.9C07B856; Wed, 27 Dec 2023 09:33:13 +0900 (KST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: RE:(2) [PATCH v3] f2fs: New victim selection for GC
Reply-To: yonggil.song@samsung.com
Sender: Yonggil Song <yonggil.song@samsung.com>
From: Yonggil Song <yonggil.song@samsung.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>
CC: "chao@kernel.org" <chao@kernel.org>,
	"linux-f2fs-devel@lists.sourceforge.net"
	<linux-f2fs-devel@lists.sourceforge.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Seokhwan Kim <sukka.kim@samsung.com>, Daejun
	Park <daejun7.park@samsung.com>, Siwoo Jung <siu.jung@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <ZYtKBKQtGS7lfBJG@google.com>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20231227003313epcms2p70281973eca22f2e0af6cce4ebb52abbf@epcms2p7>
Date: Wed, 27 Dec 2023 09:33:13 +0900
X-CMS-MailID: 20231227003313epcms2p70281973eca22f2e0af6cce4ebb52abbf
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrLKsWRmVeSWpSXmKPExsWy7bCmhe7Jgu5Ug21HJCxOTz3LZLHqQbjF
	k/WzmC0uLXK3uLxrDpvF+YmvgcIdcxkd2D02repk89i94DOTR9+WVYwenzfJBbBEZdtkpCam
	pBYppOYl56dk5qXbKnkHxzvHm5oZGOoaWlqYKynkJeam2iq5+AToumXmAO1XUihLzCkFCgUk
	Fhcr6dvZFOWXlqQqZOQXl9gqpRak5BSYF+gVJ+YWl+al6+WlllgZGhgYmQIVJmRnXNl0lLlg
	kl/FjRN7mRoYv1l1MXJwSAiYSMz9qtnFyMUhJLCDUeLc8l5WkDivgKDE3x3CXYycHMICNhIb
	G1oZQWwhASWJawd6WSDi+hKbFy9jB7HZBHQl/m5YDmaLCKhIHFp0GcxmFtjEJHHpsDqILSHA
	KzGj/SkLhC0tsX35VrCZnAJaEst6H0PFNSR+LOtlhrBFJW6ufssOY78/Np8RwhaRaL13FqpG
	UOLBz91QcUmJRYfOM0HY+RJ/V1xng7BrJLY2tEHF9SWudWwE28Ur4Ctxq2srWJxFQFViV9Mq
	qBtcJLZ2zGSBuF9eYvvbOcygIGEW0JRYv0sfEmrKEkduQVXwSXQc/ssO8+GOeU+gNqlJbN60
	mRXClpG48LgN6koPiT1L/zJNYFSchQjnWUh2zULYtYCReRWjWGpBcW56arJRgSE8ZpPzczcx
	gtOhlvMOxivz/+kdYmTiYDzEKMHBrCTCK6vYkSrEm5JYWZValB9fVJqTWnyI0RToy4nMUqLJ
	+cCEnFcSb2hiaWBiZmZobmRqYK4kznuvdW6KkEB6YklqdmpqQWoRTB8TB6dUA1NGj3eSvOy1
	i3IGtSEfOCcfZErn8W4vZnmuYdaeWL/v9rb4vSuryy/xB5WHl7z/tnutstbPDZ6Jn77enFnW
	f2a9ns3ULtv7js/vcKx75N/6N05AhfduhSt/YrtBkZiFl/3uhbyX0uWMROrnXzjbfHWrVsu0
	B7P4bZ9ytra2TX4qYbbW+7Xyyntafk3fOU5wrvq9QCv+9HrB8HSJ0gv72EI4fhp67DBa4Tr5
	XfuGqd8e5TzMKVZRjnsqrbdzu/7qxrho5YXc7U8lJpyb2ZneEdo65eaDgzqJuU+zmmeFmX+e
	ua/Nd3fs1Enz584RteMJT16zd31O1oRt51qyv7n3qUVZHWQ+pRbw6bpuXC//biWW4oxEQy3m
	ouJEAN7PcwkQBAAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231221055630epcms2p25ae1ac5e4509d5c8ba7f338b51592e53
References: <ZYtKBKQtGS7lfBJG@google.com>
	<20231221055630epcms2p25ae1ac5e4509d5c8ba7f338b51592e53@epcms2p2>
	<CGME20231221055630epcms2p25ae1ac5e4509d5c8ba7f338b51592e53@epcms2p7>

> On 12/21, Yonggil Song wrote:
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
> >  fs/f2fs/f2fs.h |   1 +
> >  fs/f2fs/gc.c   | 102 +++++++++++++++++++++++++++++++++++++++----------
> >  fs/f2fs/gc.h   |   6 +++
> >  3 files changed, 88 insertions(+), 21 deletions(-)
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
> 
> 	bool require_node_gc;
> 
> >  	struct f2fs_rwsem gc_lock;		/*
> >  						 * semaphore for GC, avoid
> >  						 * race between GC and GC or CP
> > diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> > index f550cdeaa663..da963765e087 100644
> > --- a/fs/f2fs/gc.c
> > +++ b/fs/f2fs/gc.c
> > @@ -341,6 +341,14 @@ static unsigned int get_cb_cost(struct f2fs_sb_info *sbi, unsigned int segno)
> >  	unsigned int i;
> >  	unsigned int usable_segs_per_sec = f2fs_usable_segs_in_sec(sbi, segno);
> >  
> > +	/*
> > +	 * When BG_GC selects victims based on age, it prevents node victims
> > +	 * from being selected. This is because node blocks can be invalidated
> > +	 * by moving data blocks.
> > +	 */
> > +	if (is_skip(sbi, segno))
> > +		return UINT_MAX;
> > +
> >  	for (i = 0; i < usable_segs_per_sec; i++)
> >  		mtime += get_seg_entry(sbi, start + i)->mtime;
> >  	vblocks = get_valid_blocks(sbi, segno, true);
> > @@ -369,10 +377,27 @@ static inline unsigned int get_gc_cost(struct f2fs_sb_info *sbi,
> >  		return get_seg_entry(sbi, segno)->ckpt_valid_blocks;
> >  
> >  	/* alloc_mode == LFS */
> > -	if (p->gc_mode == GC_GREEDY)
> > -		return get_valid_blocks(sbi, segno, true);
> > -	else if (p->gc_mode == GC_CB)
> > +	if (p->gc_mode == GC_GREEDY) {
> > +		unsigned int weight = 0;
> > +		unsigned int no_need = sbi->need_node_clean ? 0 : 1;
> > +		bool is_node =
> > +			IS_NODESEG(get_seg_entry(sbi, segno)->type);
> > +
> > +		/*
> > +		 * If the data block that the node block pointed to is GCed,
> > +		 * the node block is invalidated. For this reason, we add a
> > +		 * weight to cost of node victims to give priority to data
> > +		 * victims during the gc process. However, in a situation
> > +		 * where we run out of free sections, we remove the weight
> > +		 * because we need to clean up node blocks.
> > +		 */
> > +		weight = is_node ?
> > +			no_need * (sbi->blocks_per_seg * sbi->segs_per_sec) : 0;
> 
> 		unsigned int cost = get_valid_blocks(sbi, segno, true);
> 
> 		if (__skip_node_gc())
> 			return cost + (sbi->segs_per_sec << sbi->log_blocks_per_seg);
> 		return cost;
> 
> > +
> > +		return (get_valid_blocks(sbi, segno, true) + weight);
> > +	} else if (p->gc_mode == GC_CB) {
> >  		return get_cb_cost(sbi, segno);
> > +	}
> >  
> >  	f2fs_bug_on(sbi, 1);
> >  	return 0;
> > @@ -557,6 +582,14 @@ static void atgc_lookup_victim(struct f2fs_sb_info *sbi,
> >  	if (ve->mtime >= max_mtime || ve->mtime < min_mtime)
> >  		goto skip;
> >  
> > +	/*
> > +	 * When BG_GC selects victims based on age, it prevents node victims
> > +	 * from being selected. This is because node blocks can be invalidated
> > +	 * by moving data blocks.
> > +	 */
> > +	if (is_skip(sbi, ve->segno))
> > +		goto skip;
> > +
> >  	/* age = 10000 * x% * 60 */
> >  	age = div64_u64(accu * (max_mtime - ve->mtime), total_time) *
> >  								age_weight;
> > @@ -913,7 +946,22 @@ int f2fs_get_victim(struct f2fs_sb_info *sbi, unsigned int *result,
> >  		goto retry;
> >  	}
> >  
> > +
> >  	if (p.min_segno != NULL_SEGNO) {
> > +		if (sbi->need_node_clean &&
> > +		    IS_DATASEG(get_seg_entry(sbi, p.min_segno)->type)) {
> > +			 /*
> > +			  * We need to clean node sections. but, data victim
> > +			  * cost is the lowest. If free sections are enough,
> > +			  * stop cleaning node victim. If not, it goes on
> > +			  * by GCing data victims.
> > +			  */
> > +			if (has_enough_free_secs(sbi, prefree_segments(sbi), 0)) {
> > +				sbi->need_node_clean = false;
> > +				p.min_segno = NULL_SEGNO;
> > +				goto out;
> > +			}
> > +		}
> >  got_it:
> >  		*result = (p.min_segno / p.ofs_unit) * p.ofs_unit;
> >  got_result:
> > @@ -1830,8 +1878,27 @@ int f2fs_gc(struct f2fs_sb_info *sbi, struct f2fs_gc_control *gc_control)
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
> > @@ -1882,7 +1949,13 @@ int f2fs_gc(struct f2fs_sb_info *sbi, struct f2fs_gc_control *gc_control)
> >  			if (!gc_control->no_bg_gc &&
> >  			    total_sec_freed < gc_control->nr_free_secs)
> >  				goto go_gc_more;
> > -			goto stop;
> > +			/*
> > +			 * If need_node_clean flag is set even though there
> > +			 * are enough free sections, node cleaning will
> > +			 * continue.
> > +			 */
> > +			if (!sbi->need_node_clean)
> > +				goto stop;
> >  		}
> >  		if (sbi->skipped_gc_rwsem)
> >  			skipped_round++;
> > @@ -1897,21 +1970,6 @@ int f2fs_gc(struct f2fs_sb_info *sbi, struct f2fs_gc_control *gc_control)
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
> > @@ -1920,8 +1978,10 @@ int f2fs_gc(struct f2fs_sb_info *sbi, struct f2fs_gc_control *gc_control)
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
> > diff --git a/fs/f2fs/gc.h b/fs/f2fs/gc.h
> > index 28a00942802c..b0af7c086b66 100644
> > --- a/fs/f2fs/gc.h
> > +++ b/fs/f2fs/gc.h
> > @@ -166,3 +166,9 @@ static inline bool has_enough_invalid_blocks(struct f2fs_sb_info *sbi)
> >  		free_user_blocks(sbi) <
> >  			limit_free_user_blocks(invalid_user_blocks));
> >  }
> > +
> > +static inline bool is_skip(struct f2fs_sb_info *sbi, unsigned int segno)
> 
> It looks quite hard to understand what is_skip means. What about __skip_node_gc()?

Agree, It looks better to understand. I'll resend v4 with your all comments.

> 
> > +{
> > +	return (IS_NODESEG(get_seg_entry(sbi, segno)->type) &&
> > +		!sbi->need_node_clean);
> > +}
> > -- 
> > 2.34.1

