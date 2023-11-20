Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D59E57F11EB
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 12:27:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233050AbjKTL1P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 06:27:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232649AbjKTL1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 06:27:13 -0500
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8AC89D
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 03:27:07 -0800 (PST)
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20231120112705epoutp023eb04f8ba3720f8d3e049c8e7271baff~ZUTWxKwqO0929709297epoutp02M
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 11:27:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20231120112705epoutp023eb04f8ba3720f8d3e049c8e7271baff~ZUTWxKwqO0929709297epoutp02M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1700479625;
        bh=bpZOhY/GhpO+l6dOnhYbxV5P4wZ4pF9meKRSZnzf1g8=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=e5vkjpm0LDh/Sa/PxZq0M6Fc5pYJBjtFhs2jRB9V0HVblYBFmbtepLPNVXe54Hy5X
         4lXT+UV2IAONpn1yNiF68lz4dTUhoZpYrrn3aui+k+S/LIT7aKKwdoGChZZ2PYifHe
         vPavSzCIuaC/uSLBRD55UD9ISRHrRRKxARjAoil4=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20231120112704epcas2p1e17db548167e332f7e692cebafbf6510~ZUTV48jle1130811308epcas2p1T;
        Mon, 20 Nov 2023 11:27:04 +0000 (GMT)
Received: from epsmgec2p1-new.samsung.com (unknown [182.195.36.100]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4SYlbC6L9lz4x9Px; Mon, 20 Nov
        2023 11:27:03 +0000 (GMT)
X-AuditID: b6c32a4d-9f7ff70000004a32-d6-655b4287b49c
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmgec2p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
        AF.7B.18994.7824B556; Mon, 20 Nov 2023 20:27:03 +0900 (KST)
Mime-Version: 1.0
Subject: RE:(2) [f2fs-dev] [PATCH v1] f2fs: New victim selection for GC
Reply-To: yonggil.song@samsung.com
Sender: Yonggil Song <yonggil.song@samsung.com>
From:   Yonggil Song <yonggil.song@samsung.com>
To:     Jaegeuk Kim <jaegeuk@kernel.org>
CC:     "chao@kernel.org" <chao@kernel.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Seokhwan Kim <sukka.kim@samsung.com>,
        Daejun Park <daejun7.park@samsung.com>,
        Siwoo Jung <siu.jung@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <ZVekM0GmX-Jz4T0C@google.com>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20231120112702epcms2p4e4408fed82d4385624eb32b17880e613@epcms2p4>
Date:   Mon, 20 Nov 2023 20:27:02 +0900
X-CMS-MailID: 20231120112702epcms2p4e4408fed82d4385624eb32b17880e613
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprEJsWRmVeSWpSXmKPExsWy7bCmhW67U3SqwZPdOhanp55lsnhyoJ3R
        YtWDcIsn62cxWyxsW8JicWmRu8XlXXPYLM5PfM1ksapjLqMDp8emVZ1sHrsXfGbyWNw3mdWj
        b8sqRo/Pm+QCWKOybTJSE1NSixRS85LzUzLz0m2VvIPjneNNzQwMdQ0tLcyVFPISc1NtlVx8
        AnTdMnOAzlFSKEvMKQUKBSQWFyvp29kU5ZeWpCpk5BeX2CqlFqTkFJgX6BUn5haX5qXr5aWW
        WBkaGBiZAhUmZGcsfdPKXNAZVdFycwNjA2OTWxcjJ4eEgInEq7uXmboYuTiEBPYwSqxbd5ml
        i5GDg1dAUOLvDmGQGmEBd4m/befZQGwhASWJawd6WSDi+hKbFy9jB7HZBHQl/m5YDmaLCKhI
        HFp0mR1kJrPABGaJC12v2SCW8UrMaH/KAmFLS2xfvpURxOYU0JL4+fInVFxD4seyXmYIW1Ti
        5uq37DD2+2PzGSFsEYnWe2ehagQlHvzcDRWXlFh06DwThJ0v8XfFdai9NRJbG9qg4voS1zo2
        gu3iFfCVuHFhKth8FgFViQOTu6BqXCS6n88FizMLyEtsfzuHGRQmzAKaEut36YOYEgLKEkdu
        sUBU8El0HP7LDvPhjnlPoKaoSWzetJkVwpaRuPC4DepKD4npO7czTWBUnIUI6FlIds1C2LWA
        kXkVo1RqQXFuemqyUYGhbl5qOTx+k/NzNzGCE6eW7w7G1+v/6h1iZOJgPMQowcGsJML7TSgi
        VYg3JbGyKrUoP76oNCe1+BCjKdCnE5mlRJPzgak7ryTe0MTSwMTMzNDcyNTAXEmc917r3BQh
        gfTEktTs1NSC1CKYPiYOTqkGJrvNbsm7r0aKJM1f/nHLhbudb0PzFY+82cC+dXtrYmgm+0XP
        C/MWxryyrrbiP/Bbbm/Njg3NG/ZcvM7F8lD60XrfaO/X7+ezBOmvWrf10g/WTI3tb58/ML/+
        zLlrw+sG44r4aKULTu9u2k2/5v7hyYfr8wQOcJWfeXD+4e6WyZx3bl9xdbm02PjW0lIm73tB
        i65yfkxJixJc/TF5yvXIGMfXrZbLFwWqnX+/ne+ExAOFjjnhzpbPHfdWKuxrbGz65SB2atGn
        KeJaqn1fg3c+Y06asuXY8bgJRgfbIjcz5jN9kCp2XVtVI3/4dL9OdOCN3QnVzs/6ZjuYCsUn
        VbjvsYo/fXszw9bCE+y9mXMmNp9QYinOSDTUYi4qTgQA21tnviUEAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231012100345epcms2p84b95e24ee5e7965858ab8be99fbc3eff
References: <ZVekM0GmX-Jz4T0C@google.com>
        <20231012100345epcms2p84b95e24ee5e7965858ab8be99fbc3eff@epcms2p8>
        <20231026091838epcms2p46f14260fdaf53e27ee6374887ed87f41@epcms2p4>
        <CGME20231012100345epcms2p84b95e24ee5e7965858ab8be99fbc3eff@epcms2p4>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>Hi Yonggil,
>
>On 10/26, Yonggil Song wrote:
>> Overview
>> ========
>> 
>> Introduce a new way to select the data section first when selecting a
>> victim in foreground GC. This victim selection method works when the
>> prefer_data_victim mount option is enabled. If foreground GC migrates only
>> data sections and runs out of free sections, it cleans dirty node sections
>> to get more free sections.
>> 
>> Problem
>> =======
>> 
>> If the total amount of nodes is larger than the size of one section, nodes
>> occupy multiple sections, and node victims are often selected because the
>> gc cost is lowered by data block migration in foreground gc. Since moving
>> the data section causes frequent node victim selection, victim threshing
>> occurs in the node section. This results in an increase in WAF.
>
>How does that work w/ ATGC?
>

Hi jaegeuk.

I didn't consider ATGC because this feature is only supported by zoned devices(LFS).
I didn't add ATGC exception handling because I'm only enabling this feature when
it's a zoned device, but should I?

>> 
>> Experiment
>> ==========
>> 
>> Test environment is as follows.
>> 
>> 	System info
>> 	  - 3.6GHz, 16 core CPU
>> 	  - 36GiB Memory
>> 	Device info
>> 	  - a conventional null_blk with 228MiB
>> 	  - a sequential null_blk with 4068 zones of 8MiB
>> 	Format
>> 	  - mkfs.f2fs <conv null_blk> -c <seq null_blk> -m -Z 8 -o 3.89
>> 	Mount
>> 	  - mount -o prefer_data_victim <conv null_blk> <mount point>
>> 	Fio script
>> 	  - fio --rw=randwrite --bs=4k --ba=4k --filesize=31187m --norandommap --overwrite=1 --name=job1 --filename=./mnt/sustain --io_size=128g
>> 	WAF calculation
>> 	  - (IOs on conv. null_blk + IOs on seq. null_blk) / random write IOs
>> 
>> Conclusion
>> ==========
>> 
>> This experiment showed that the WAF was reduced by 29% (18.75 -> 13.3) when
>> the data section was selected first when selecting GC victims. This was
>> achieved by reducing the migration of the node blocks by 69.4%
>> (253,131,743 blks -> 77,463,278 blks). It is possible to achieve low WAF
>> performance with the GC victim selection method in environments where the
>> section size is relatively small.
>> 
>> Signed-off-by: Yonggil Song <yonggil.song@samsung.com>
>> ---
>>  Documentation/filesystems/f2fs.rst |   3 +
>>  fs/f2fs/f2fs.h                     |   2 +
>>  fs/f2fs/gc.c                       | 100 +++++++++++++++++++++++------
>>  fs/f2fs/segment.h                  |   2 +
>>  fs/f2fs/super.c                    |   9 +++
>>  5 files changed, 95 insertions(+), 21 deletions(-)
>> 
>> diff --git a/Documentation/filesystems/f2fs.rst b/Documentation/filesystems/f2fs.rst
>> index d32c6209685d..58e6d001d7ab 100644
>> --- a/Documentation/filesystems/f2fs.rst
>> +++ b/Documentation/filesystems/f2fs.rst
>> @@ -367,6 +367,9 @@ errors=%s		 Specify f2fs behavior on critical errors. This supports modes:
>>  			 pending node write	drop		keep		N/A
>>  			 pending meta write	keep		keep		N/A
>>  			 ====================== =============== =============== ========
>> +prefer_data_victim	 When selecting victims in foreground GC, victims of data type
>> +			 are prioritized. This option minimizes GC victim threshing
>> +			 in the node section to reduce WAF.
>>  ======================== ============================================================
>>  
>>  Debugfs Entries
>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>> index 6d688e42d89c..8b31fa2ea09a 100644
>> --- a/fs/f2fs/f2fs.h
>> +++ b/fs/f2fs/f2fs.h
>> @@ -108,6 +108,7 @@ extern const char *f2fs_fault_name[FAULT_MAX];
>>  #define	F2FS_MOUNT_GC_MERGE		0x02000000
>>  #define F2FS_MOUNT_COMPRESS_CACHE	0x04000000
>>  #define F2FS_MOUNT_AGE_EXTENT_CACHE	0x08000000
>> +#define F2FS_MOUNT_PREFER_DATA_VICTIM	0x10000000
>>  
>>  #define F2FS_OPTION(sbi)	((sbi)->mount_opt)
>>  #define clear_opt(sbi, option)	(F2FS_OPTION(sbi).opt &= ~F2FS_MOUNT_##option)
>> @@ -1648,6 +1649,7 @@ struct f2fs_sb_info {
>>  	struct f2fs_mount_info mount_opt;	/* mount options */
>>  
>>  	/* for cleaning operations */
>> +	bool need_node_clean;			/* only used for prefer_data_victim */
>>  	struct f2fs_rwsem gc_lock;		/*
>>  						 * semaphore for GC, avoid
>>  						 * race between GC and GC or CP
>> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
>> index f550cdeaa663..8a2da808a5fb 100644
>> --- a/fs/f2fs/gc.c
>> +++ b/fs/f2fs/gc.c
>> @@ -752,6 +752,8 @@ int f2fs_get_victim(struct f2fs_sb_info *sbi, unsigned int *result,
>>  	unsigned int last_segment;
>>  	unsigned int nsearched;
>>  	bool is_atgc;
>> +	bool is_prefer_data_victim =
>> +		test_opt(sbi, PREFER_DATA_VICTIM) && gc_type == FG_GC;
>>  	int ret = 0;
>>  
>>  	mutex_lock(&dirty_i->seglist_lock);
>> @@ -767,6 +769,11 @@ int f2fs_get_victim(struct f2fs_sb_info *sbi, unsigned int *result,
>>  	p.oldest_age = 0;
>>  	p.min_cost = get_max_cost(sbi, &p);
>>  
>> +	if (is_prefer_data_victim) {
>> +		p.node_min_cost = p.min_cost;
>> +		p.node_min_segno = p.min_segno;
>> +	}
>> +
>>  	is_atgc = (p.gc_mode == GC_AT || p.alloc_mode == AT_SSR);
>>  	nsearched = 0;
>>  
>> @@ -884,9 +891,25 @@ int f2fs_get_victim(struct f2fs_sb_info *sbi, unsigned int *result,
>>  
>>  		cost = get_gc_cost(sbi, segno, &p);
>>  
>> -		if (p.min_cost > cost) {
>> -			p.min_segno = segno;
>> -			p.min_cost = cost;
>> +		if (is_prefer_data_victim) {
>> +			if (IS_DATASEG(get_seg_entry(sbi, segno)->type)) {
>> +				/* update data segments victim */
>> +				if (p.min_cost > cost) {
>> +					p.min_segno = segno;
>> +					p.min_cost = cost;
>> +				}
>> +			} else {
>> +				/* update node segments victim */
>> +				if (p.node_min_cost > cost) {
>> +					p.node_min_segno = segno;
>> +					p.node_min_cost = cost;
>> +				}
>> +			}
>> +		} else {
>> +			if (p.min_cost > cost) {
>> +				p.min_segno = segno;
>> +				p.min_cost = cost;
>> +			}
>>  		}
>>  next:
>>  		if (nsearched >= p.max_search) {
>> @@ -901,6 +924,25 @@ int f2fs_get_victim(struct f2fs_sb_info *sbi, unsigned int *result,
>>  		}
>>  	}
>>  
>> +	if (is_prefer_data_victim && sbi->need_node_clean) {
>> +		/* we need to clean node sections */
>> +		if (p.min_cost > p.node_min_cost) {
>> +			p.min_segno = p.node_min_segno;
>> +			p.min_cost = p.node_min_cost;
>> +		} else {
>> +			/*
>> +			 * data victim cost is the lowest.
>> +			 * if free sections are enough, stop cleaning node victim.
>> +			 * if not, it goes on by GCing data victims.
>> +			 */
>> +			if (has_enough_free_secs(sbi, prefree_segments(sbi), 0)) {
>> +				sbi->need_node_clean = false;
>> +				p.min_segno = NULL_SEGNO;
>> +				goto out;
>> +			}
>> +		}
>> +	}
>> +
>>  	/* get victim for GC_AT/AT_SSR */
>>  	if (is_atgc) {
>>  		lookup_victim_by_age(sbi, &p);
>> @@ -1830,8 +1872,27 @@ int f2fs_gc(struct f2fs_sb_info *sbi, struct f2fs_gc_control *gc_control)
>>  		goto stop;
>>  	}
>>  
>> +	__get_secs_required(sbi, NULL, &upper_secs, NULL);
>> +
>> +	/*
>> +	 * Write checkpoint to reclaim prefree segments.
>> +	 * We need more three extra sections for writer's data/node/dentry.
>> +	 */
>> +	if (free_sections(sbi) <= upper_secs + NR_GC_CHECKPOINT_SECS) {
>> +		if (test_opt(sbi, PREFER_DATA_VICTIM)) {
>> +			sbi->need_node_clean = true;
>> +		}
>> +		if (prefree_segments(sbi)) {
>> +			ret = f2fs_write_checkpoint(sbi, &cpc);
>> +			if (ret)
>> +				goto stop;
>> +			/* Reset due to checkpoint */
>> +			sec_freed = 0;
>> +		}
>> +	}
>> +
>>  	/* Let's run FG_GC, if we don't have enough space. */
>> -	if (has_not_enough_free_secs(sbi, 0, 0)) {
>> +	if (gc_type == BG_GC && has_not_enough_free_secs(sbi, 0, 0)) {
>>  		gc_type = FG_GC;
>>  
>>  		/*
>> @@ -1882,7 +1943,17 @@ int f2fs_gc(struct f2fs_sb_info *sbi, struct f2fs_gc_control *gc_control)
>>  			if (!gc_control->no_bg_gc &&
>>  			    total_sec_freed < gc_control->nr_free_secs)
>>  				goto go_gc_more;
>> -			goto stop;
>> +			if (test_opt(sbi, PREFER_DATA_VICTIM)) {
>> +				/*
>> +				 * If the need_node_clean flag is set
>> +				 * even though there are enough free
>> +				 * sections, node cleaning will continue.
>> +				 */
>> +				if (!sbi->need_node_clean)
>> +					goto stop;
>> +			} else {
>> +				goto stop;
>> +			}
>>  		}
>>  		if (sbi->skipped_gc_rwsem)
>>  			skipped_round++;
>> @@ -1897,21 +1968,6 @@ int f2fs_gc(struct f2fs_sb_info *sbi, struct f2fs_gc_control *gc_control)
>>  		goto stop;
>>  	}
>>  
>> -	__get_secs_required(sbi, NULL, &upper_secs, NULL);
>> -
>> -	/*
>> -	 * Write checkpoint to reclaim prefree segments.
>> -	 * We need more three extra sections for writer's data/node/dentry.
>> -	 */
>> -	if (free_sections(sbi) <= upper_secs + NR_GC_CHECKPOINT_SECS &&
>> -				prefree_segments(sbi)) {
>> -		stat_inc_cp_call_count(sbi, TOTAL_CALL);
>> -		ret = f2fs_write_checkpoint(sbi, &cpc);
>> -		if (ret)
>> -			goto stop;
>> -		/* Reset due to checkpoint */
>> -		sec_freed = 0;
>> -	}
>>  go_gc_more:
>>  	segno = NULL_SEGNO;
>>  	goto gc_more;
>> @@ -1920,8 +1976,10 @@ int f2fs_gc(struct f2fs_sb_info *sbi, struct f2fs_gc_control *gc_control)
>>  	SIT_I(sbi)->last_victim[ALLOC_NEXT] = 0;
>>  	SIT_I(sbi)->last_victim[FLUSH_DEVICE] = gc_control->victim_segno;
>>  
>> -	if (gc_type == FG_GC)
>> +	if (gc_type == FG_GC) {
>>  		f2fs_unpin_all_sections(sbi, true);
>> +		sbi->need_node_clean = false;
>> +	}
>>  
>>  	trace_f2fs_gc_end(sbi->sb, ret, total_freed, total_sec_freed,
>>  				get_pages(sbi, F2FS_DIRTY_NODES),
>> diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
>> index 2ca8fb5d0dc4..d55fa1fee2e0 100644
>> --- a/fs/f2fs/segment.h
>> +++ b/fs/f2fs/segment.h
>> @@ -197,8 +197,10 @@ struct victim_sel_policy {
>>  	unsigned int offset;		/* last scanned bitmap offset */
>>  	unsigned int ofs_unit;		/* bitmap search unit */
>>  	unsigned int min_cost;		/* minimum cost */
>> +	unsigned int node_min_cost;	/* minimum cost of node type section */
>>  	unsigned long long oldest_age;	/* oldest age of segments having the same min cost */
>>  	unsigned int min_segno;		/* segment # having min. cost */
>> +	unsigned int node_min_segno;	/* node segment # having min. cost */
>>  	unsigned long long age;		/* mtime of GCed section*/
>>  	unsigned long long age_threshold;/* age threshold */
>>  };
>> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
>> index a8c8232852bb..133137dd6fd0 100644
>> --- a/fs/f2fs/super.c
>> +++ b/fs/f2fs/super.c
>> @@ -165,6 +165,7 @@ enum {
>>  	Opt_memory_mode,
>>  	Opt_age_extent_cache,
>>  	Opt_errors,
>> +	Opt_prefer_data_victim,
>>  	Opt_err,
>>  };
>>  
>> @@ -245,6 +246,7 @@ static match_table_t f2fs_tokens = {
>>  	{Opt_memory_mode, "memory=%s"},
>>  	{Opt_age_extent_cache, "age_extent_cache"},
>>  	{Opt_errors, "errors=%s"},
>> +	{Opt_prefer_data_victim, "prefer_data_victim"},
>>  	{Opt_err, NULL},
>>  };
>>  
>> @@ -1286,6 +1288,13 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
>>  			}
>>  			kfree(name);
>>  			break;
>> +		case Opt_prefer_data_victim:
>> +			if (!f2fs_sb_has_blkzoned(sbi)) {
>> +				f2fs_err(sbi, "prefer_data_victim is only allowed with zoned block device feature");
>> +				return -EINVAL;
>> +			}
>> +			set_opt(sbi, PREFER_DATA_VICTIM);
>> +			break;
>>  		default:
>>  			f2fs_err(sbi, "Unrecognized mount option \"%s\" or missing value",
>>  				 p);
>> -- 
>> 2.34.1
