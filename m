Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B0847FB1F0
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 07:31:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343633AbjK1GXC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 01:23:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234629AbjK1GWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 01:22:50 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B37319D
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 22:22:55 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-332e56363adso3099644f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 22:22:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701152574; x=1701757374; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hPtGbvFvbBhWiAO0KqjHdk9TS5G0CVYCi0szrUGqbGw=;
        b=GFdNKytJ32SXuTHgVN8KQcJsP1Y/ePVMtS1MZWmeOEhvfMv8KYn/YaUnlZwbHpDX22
         20P7WyoPChwgwbjZ3v+8RpcoM/pkBNndHWYQZvuRjgrt1P4Emq0lxwRtlPmfGoVMCNhk
         j9AGnIZxZB+3bvwgRziAFH2ZacVwrDDclYRREu+zxeDt5XpAJ2SEGdbITclIoqvEEpOl
         ovPVr+hEr3z0Ojsft3nTUvuYHX5PJ/jVL8d+/2pr77YbCYnBcflal3Z4akL7IQRGGaUn
         CQBPJcP6MttTtG6ERrSWmnjW/HDSE1/sGiRzHLwmU7GhjTxt4iSGuzQ5c3Sae3vYFDkc
         b5pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701152574; x=1701757374;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hPtGbvFvbBhWiAO0KqjHdk9TS5G0CVYCi0szrUGqbGw=;
        b=aHRuHrNDmNyiUVf+Pl9NGluN2le7uzsmeKM4Yr7MWlaT7AHa/pMiebe9iU+dMh2dqO
         WGfqXB6izILLx1IlXrDjW7S1ulxdV/0ciw+0sQb3t1TZl7aljpyE0W1nuih+oSnHO4f0
         e8AHh/IRlAIWzcuxxs9UYPHbjQZ3RjphMkPzY8y4Z3EuG0OuBdSDUtcOwC2IxbT/B2Ns
         1xqb8gS/uniUp9G+oJ39TewBxDFqZ4YFvbqGlqGqit09MvKn88xzTq2llAYyTJD4C9Hr
         gcnAqPGnvTJsQHLelvbst5azCo3x2uFTqQyetkJkBsf3e8g0ypOFhH1tD5ORD4QN/9Gy
         lw+g==
X-Gm-Message-State: AOJu0Yz/PsgNFe1TYEm62+/kZZswjv8b5B1H0ZFYDBamErsR3yQNTpM4
        5E7+lFfHheHbdBNAhUMSDPOxow==
X-Google-Smtp-Source: AGHT+IGRijsPwnlyl6qa4iz/DeWVhs98fC2QMwxlyhHJ3pF2UrZX/B6n/FQm2E9DtShpemgAFYyWOQ==
X-Received: by 2002:adf:f503:0:b0:332:fa75:a8ee with SMTP id q3-20020adff503000000b00332fa75a8eemr5275830wro.33.1701152573933;
        Mon, 27 Nov 2023 22:22:53 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id e5-20020adfe7c5000000b0033307ffb193sm2760534wrn.29.2023.11.27.22.22.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 22:22:53 -0800 (PST)
From:   Dan Carpenter <dan.carpenter@linaro.org>
X-Google-Original-From: Dan Carpenter <dan.carpenter@oracle.com>
Date:   Tue, 28 Nov 2023 09:22:50 +0300
To:     oe-kbuild@lists.linux.dev, Vineet Gupta <vgupta@kernel.org>
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org
Subject: arch/arc/kernel/setup.c:203 arcv2_mumbojumbo() error: uninitialized
 symbol 'release'.
Message-ID: <c2148229-bea9-40ef-bbf3-6019555f3f1a@suswa.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   2cc14f52aeb78ce3f29677c2de1f06c0e91471ab
commit: fad84e39f116035ae8d550c6020107b8ac113b45 ARC: boot log: eliminate struct cpuinfo_arc #4: boot log per ISA
config: arc-randconfig-r071-20231128 (https://download.01.org/0day-ci/archive/20231128/202311280906.VAIwEAfT-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231128/202311280906.VAIwEAfT-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <error27@gmail.com>
| Closes: https://lore.kernel.org/r/202311280906.VAIwEAfT-lkp@intel.com/

New smatch warnings:
arch/arc/kernel/setup.c:203 arcv2_mumbojumbo() error: uninitialized symbol 'release'.

Old smatch warnings:
arch/arc/include/asm/thread_info.h:62 current_thread_info() error: uninitialized symbol 'sp'.

vim +/release +203 arch/arc/kernel/setup.c

fad84e39f11603 Vineet Gupta 2020-06-11  150  static int arcv2_mumbojumbo(int c, struct cpuinfo_arc *info, char *buf, int len)
fad84e39f11603 Vineet Gupta 2020-06-11  151  {
fad84e39f11603 Vineet Gupta 2020-06-11  152  	int n = 0;
fad84e39f11603 Vineet Gupta 2020-06-11  153  #ifdef CONFIG_ISA_ARCV2
fad84e39f11603 Vineet Gupta 2020-06-11  154  	const char *release, *cpu_nm, *isa_nm = "ARCv2";
fad84e39f11603 Vineet Gupta 2020-06-11  155  	int dual_issue = 0, dual_enb = 0, mpy_opt, present;
fad84e39f11603 Vineet Gupta 2020-06-11  156  	int bpu_full, bpu_cache, bpu_pred, bpu_ret_stk;
fad84e39f11603 Vineet Gupta 2020-06-11  157  	char mpy_nm[16], lpb_nm[32];
fad84e39f11603 Vineet Gupta 2020-06-11  158  	struct bcr_isa_arcv2 isa;
fad84e39f11603 Vineet Gupta 2020-06-11  159  	struct bcr_mpy mpy;
fad84e39f11603 Vineet Gupta 2020-06-11  160  	struct bcr_fp_arcv2 fpu;
fad84e39f11603 Vineet Gupta 2020-06-11  161  	struct bcr_bpu_arcv2 bpu;
fad84e39f11603 Vineet Gupta 2020-06-11  162  	struct bcr_lpb lpb;
fad84e39f11603 Vineet Gupta 2020-06-11  163  	struct bcr_iccm_arcv2 iccm;
fad84e39f11603 Vineet Gupta 2020-06-11  164  	struct bcr_dccm_arcv2 dccm;
fad84e39f11603 Vineet Gupta 2020-06-11  165  	struct bcr_erp erp;
00a4ae65cc600b Vineet Gupta 2019-02-25  166  
00a4ae65cc600b Vineet Gupta 2019-02-25  167  	/*
97d0b5d0b5a998 Vineet Gupta 2020-06-10  168  	 * Initial HS cores bumped AUX IDENTITY.ARCVER for each release until
97d0b5d0b5a998 Vineet Gupta 2020-06-10  169  	 * ARCVER 0x54 which introduced AUX MICRO_ARCH_BUILD and subsequent
97d0b5d0b5a998 Vineet Gupta 2020-06-10  170  	 * releases only update it.
00a4ae65cc600b Vineet Gupta 2019-02-25  171  	 */
00a4ae65cc600b Vineet Gupta 2019-02-25  172  
fad84e39f11603 Vineet Gupta 2020-06-11  173  	cpu_nm = "HS38";
00a4ae65cc600b Vineet Gupta 2019-02-25  174  
fad84e39f11603 Vineet Gupta 2020-06-11  175  	if (info->arcver > 0x50 && info->arcver <= 0x53) {
fad84e39f11603 Vineet Gupta 2020-06-11  176  		release = arc_hs_rel[info->arcver - 0x51].str;
00a4ae65cc600b Vineet Gupta 2019-02-25  177  	} else {
fad84e39f11603 Vineet Gupta 2020-06-11  178  		const struct id_to_str *tbl;
fad84e39f11603 Vineet Gupta 2020-06-11  179  		struct bcr_uarch_build uarch;
fad84e39f11603 Vineet Gupta 2020-06-11  180  
fad84e39f11603 Vineet Gupta 2020-06-11  181  		READ_BCR(ARC_REG_MICRO_ARCH_BCR, uarch);
00a4ae65cc600b Vineet Gupta 2019-02-25  182  
97d0b5d0b5a998 Vineet Gupta 2020-06-10  183  		for (tbl = &arc_hs_ver54_rel[0]; tbl->id != 0xFF; tbl++) {
00a4ae65cc600b Vineet Gupta 2019-02-25  184  			if (uarch.maj == tbl->id) {
fad84e39f11603 Vineet Gupta 2020-06-11  185  				release = tbl->str;

Will we always hit this assignment?

d975cbc8acb6f4 Vineet Gupta 2016-10-27  186  				break;
d975cbc8acb6f4 Vineet Gupta 2016-10-27  187  			}
00a4ae65cc600b Vineet Gupta 2019-02-25  188  		}
fad84e39f11603 Vineet Gupta 2020-06-11  189  		if (uarch.prod == 4) {
fad84e39f11603 Vineet Gupta 2020-06-11  190  			unsigned int exec_ctrl;
00a4ae65cc600b Vineet Gupta 2019-02-25  191  
fad84e39f11603 Vineet Gupta 2020-06-11  192  			cpu_nm = "HS48";
fad84e39f11603 Vineet Gupta 2020-06-11  193  			dual_issue = 1;
fad84e39f11603 Vineet Gupta 2020-06-11  194  			/* if dual issue hardware, is it enabled ? */
fad84e39f11603 Vineet Gupta 2020-06-11  195  			READ_BCR(AUX_EXEC_CTRL, exec_ctrl);
fad84e39f11603 Vineet Gupta 2020-06-11  196  			dual_enb = !(exec_ctrl & 1);
fad84e39f11603 Vineet Gupta 2020-06-11  197  		}
fad84e39f11603 Vineet Gupta 2020-06-11  198  	}
73e284d2572581 Vineet Gupta 2016-10-20  199  
fad84e39f11603 Vineet Gupta 2020-06-11  200  	READ_BCR(ARC_REG_ISA_CFG_BCR, isa);
b89bd1f4fbaeca Vineet Gupta 2016-01-22  201  
fad84e39f11603 Vineet Gupta 2020-06-11  202  	n += scnprintf(buf + n, len - n, "processor [%d]\t: %s %s (%s ISA) %s%s%s\n",
fad84e39f11603 Vineet Gupta 2020-06-11 @203  		       c, cpu_nm, release, isa_nm,
fad84e39f11603 Vineet Gupta 2020-06-11  204  		       IS_AVAIL1(isa.be, "[Big-Endian]"),
fad84e39f11603 Vineet Gupta 2020-06-11  205  		       IS_AVAIL3(dual_issue, dual_enb, " Dual-Issue "));
af61742813aa9d Vineet Gupta 2013-01-18  206  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

