Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E71EA7BA034
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 16:36:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231163AbjJEOfE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 10:35:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234962AbjJEOcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 10:32:42 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F3FE21A14
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 03:40:10 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-4056ce55e7eso6915615e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Oct 2023 03:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696502409; x=1697107209; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hcpe8rpxiNY6s6GgKaLTLVHfVFyP836KXSYgAp7SqpE=;
        b=Va24mCbq81CnDzeYTZf01p260MrDwuuBD1o2Ikau00muychZsy0v/kEvg4YKw7itVa
         ieEbIeKO1XWvVNAUmwGKuNrWt/aLC6CfP2iAsuuqj5kjUhUZunRm6Bt4xfYrdL0za+Yt
         CO+24muiQ8RPaUjP3ApGNb56LUuo7Fi7xRNEKbv0c9N4MFry5yA0svmWP5cNKBexOn39
         mULmdXSOjeuM+GgxYOqZtEj8G7EvXKI+RoCRxly2OcuojsfN0Patr4TXoMBg4iHuJwPf
         kD6p8+DdBJ7PSUh7nekP9ZdqUpNlXbF7rdSI/FjNxBna2aPfW9jUOlVMuuvHr9P50qvo
         C9XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696502409; x=1697107209;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hcpe8rpxiNY6s6GgKaLTLVHfVFyP836KXSYgAp7SqpE=;
        b=JZWH69u2vQIRXAeuRas6w4Hdf2o8ckgvIi6tXwV1SaJIS/5mc5+yYMzExEkyjtvJm5
         Cgs3w3bP/Q7tBQiPGvJB5nUzrda3H05un7h+NMqrDrqHjsuVZdiQ/bgPt4cXQNtBDt/G
         jNaGW6ptriGsqsF1GmGHAL0NCmhvzIaLDPEhrZVi3Tg+jQst02mYNS/m8S8nA8lFEvBe
         3YGkamfKZwRnyUZFD+saEOiPrUmk2InqZP20xYJoSkYeK+3DG3oh6FVOi5n/7xrcdYDO
         qEj4HqBkiqNnrSvnOR2ProWEVH9SxxGxx+zArrGFOr0ufBvy3ShSNKDWSN3sGSs9gMDl
         b8Iw==
X-Gm-Message-State: AOJu0Yxmdnoz1mBWkHEV4KQnczGeakk42TQP4mKBEeBduKxTiicC1J2k
        93lc04ExXrkzTDHo22ooEbbJfw==
X-Google-Smtp-Source: AGHT+IHkfE301rGoIUoml80of17gfam6SekWJu6NiY5tLgP7T3EWA12tZCbwvLyVJFAlNR8kDe+Wxw==
X-Received: by 2002:a1c:7914:0:b0:405:37bb:d942 with SMTP id l20-20020a1c7914000000b0040537bbd942mr4906124wme.4.1696502408717;
        Thu, 05 Oct 2023 03:40:08 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id y6-20020a1c4b06000000b00405588aa40asm1209179wma.24.2023.10.05.03.40.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 03:40:07 -0700 (PDT)
Date:   Thu, 5 Oct 2023 13:40:05 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     oe-kbuild@lists.linux.dev, Wenchao Hao <haowenchao2@huawei.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Douglas Gilbert <dgilbert@interlog.com>,
        open-iscsi@googlegroups.com, linux-scsi@vger.kernel.org
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, louhongxiang@huawei.com,
        Wenchao Hao <haowenchao2@huawei.com>
Subject: Re: [PATCH v5 06/10] scsi: scsi_debug: set command's result and
 sense data if the error is injected
Message-ID: <752bff1e-91a7-414f-a4d2-cb88fd556ead@kadam.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230922092906.2645265-7-haowenchao2@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wenchao,

kernel test robot noticed the following build warnings:

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Wenchao-Hao/scsi-scsi_debug-create-scsi_debug-directory-in-the-debugfs-filesystem/20230922-173226
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mkp/scsi.git for-next
patch link:    https://lore.kernel.org/r/20230922092906.2645265-7-haowenchao2%40huawei.com
patch subject: [PATCH v5 06/10] scsi: scsi_debug: set command's result and sense data if the error is injected
config: x86_64-randconfig-161-20231003 (https://download.01.org/0day-ci/archive/20231005/202310050209.VOl6gV40-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231005/202310050209.VOl6gV40-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202310050209.VOl6gV40-lkp@intel.com/

smatch warnings:
drivers/scsi/scsi_debug.c:7912 scsi_debug_queuecommand() warn: missing error code? 'ret'

vim +/ret +7912 drivers/scsi/scsi_debug.c

fd32119b0deac1 Douglas Gilbert 2016-04-25  7832  static int scsi_debug_queuecommand(struct Scsi_Host *shost,
fd32119b0deac1 Douglas Gilbert 2016-04-25  7833  				   struct scsi_cmnd *scp)
c2248fc974df7b Douglas Gilbert 2014-11-24  7834  {
c2248fc974df7b Douglas Gilbert 2014-11-24  7835  	u8 sdeb_i;
c2248fc974df7b Douglas Gilbert 2014-11-24  7836  	struct scsi_device *sdp = scp->device;
c2248fc974df7b Douglas Gilbert 2014-11-24  7837  	const struct opcode_info_t *oip;
c2248fc974df7b Douglas Gilbert 2014-11-24  7838  	const struct opcode_info_t *r_oip;
c2248fc974df7b Douglas Gilbert 2014-11-24  7839  	struct sdebug_dev_info *devip;
c2248fc974df7b Douglas Gilbert 2014-11-24  7840  	u8 *cmd = scp->cmnd;
c2248fc974df7b Douglas Gilbert 2014-11-24  7841  	int (*r_pfp)(struct scsi_cmnd *, struct sdebug_dev_info *);
f66b85171a0ebd Martin Wilck    2018-02-14  7842  	int (*pfp)(struct scsi_cmnd *, struct sdebug_dev_info *) = NULL;
c2248fc974df7b Douglas Gilbert 2014-11-24  7843  	int k, na;
c2248fc974df7b Douglas Gilbert 2014-11-24  7844  	int errsts = 0;
ad0c7775e745d2 Douglas Gilbert 2020-08-21  7845  	u64 lun_index = sdp->lun & 0x3FFF;
c2248fc974df7b Douglas Gilbert 2014-11-24  7846  	u32 flags;
c2248fc974df7b Douglas Gilbert 2014-11-24  7847  	u16 sa;
c2248fc974df7b Douglas Gilbert 2014-11-24  7848  	u8 opcode = cmd[0];
c2248fc974df7b Douglas Gilbert 2014-11-24  7849  	bool has_wlun_rl;
3a90a63d02b8b7 Douglas Gilbert 2020-07-12  7850  	bool inject_now;
929aad8ff0578d Wenchao Hao     2023-09-22  7851  	int ret = 0;
cc36ffafc0f7e6 Wenchao Hao     2023-09-22  7852  	struct sdebug_err_inject err;
c2248fc974df7b Douglas Gilbert 2014-11-24  7853  
c2248fc974df7b Douglas Gilbert 2014-11-24  7854  	scsi_set_resid(scp, 0);
3a90a63d02b8b7 Douglas Gilbert 2020-07-12  7855  	if (sdebug_statistics) {
c483739430f107 Douglas Gilbert 2016-05-06  7856  		atomic_inc(&sdebug_cmnd_count);
3a90a63d02b8b7 Douglas Gilbert 2020-07-12  7857  		inject_now = inject_on_this_cmd();
3a90a63d02b8b7 Douglas Gilbert 2020-07-12  7858  	} else {
3a90a63d02b8b7 Douglas Gilbert 2020-07-12  7859  		inject_now = false;
3a90a63d02b8b7 Douglas Gilbert 2020-07-12  7860  	}
f46eb0e9fc763b Douglas Gilbert 2016-04-25  7861  	if (unlikely(sdebug_verbose &&
f46eb0e9fc763b Douglas Gilbert 2016-04-25  7862  		     !(SDEBUG_OPT_NO_CDB_NOISE & sdebug_opts))) {
c2248fc974df7b Douglas Gilbert 2014-11-24  7863  		char b[120];
c2248fc974df7b Douglas Gilbert 2014-11-24  7864  		int n, len, sb;
c2248fc974df7b Douglas Gilbert 2014-11-24  7865  
c2248fc974df7b Douglas Gilbert 2014-11-24  7866  		len = scp->cmd_len;
c2248fc974df7b Douglas Gilbert 2014-11-24  7867  		sb = (int)sizeof(b);
c2248fc974df7b Douglas Gilbert 2014-11-24  7868  		if (len > 32)
c2248fc974df7b Douglas Gilbert 2014-11-24  7869  			strcpy(b, "too long, over 32 bytes");
c2248fc974df7b Douglas Gilbert 2014-11-24  7870  		else {
c2248fc974df7b Douglas Gilbert 2014-11-24  7871  			for (k = 0, n = 0; k < len && n < sb; ++k)
c2248fc974df7b Douglas Gilbert 2014-11-24  7872  				n += scnprintf(b + n, sb - n, "%02x ",
c2248fc974df7b Douglas Gilbert 2014-11-24  7873  					       (u32)cmd[k]);
c2248fc974df7b Douglas Gilbert 2014-11-24  7874  		}
458df78b1c513d Bart Van Assche 2018-01-26  7875  		sdev_printk(KERN_INFO, sdp, "%s: tag=%#x, cmd %s\n", my_name,
a6e76e6f2c0efd Bart Van Assche 2021-08-09  7876  			    blk_mq_unique_tag(scsi_cmd_to_rq(scp)), b);
c2248fc974df7b Douglas Gilbert 2014-11-24  7877  	}
3a90a63d02b8b7 Douglas Gilbert 2020-07-12  7878  	if (unlikely(inject_now && (sdebug_opts & SDEBUG_OPT_HOST_BUSY)))
7ee6d1b4357ac2 Bart Van Assche 2017-12-07  7879  		return SCSI_MLQUEUE_HOST_BUSY;
34d55434ba1f39 Tomas Winkler   2015-07-28  7880  	has_wlun_rl = (sdp->lun == SCSI_W_LUN_REPORT_LUNS);
ad0c7775e745d2 Douglas Gilbert 2020-08-21  7881  	if (unlikely(lun_index >= sdebug_max_luns && !has_wlun_rl))
f46eb0e9fc763b Douglas Gilbert 2016-04-25  7882  		goto err_out;
c2248fc974df7b Douglas Gilbert 2014-11-24  7883  
c2248fc974df7b Douglas Gilbert 2014-11-24  7884  	sdeb_i = opcode_ind_arr[opcode];	/* fully mapped */
c2248fc974df7b Douglas Gilbert 2014-11-24  7885  	oip = &opcode_info_arr[sdeb_i];		/* safe if table consistent */
c2248fc974df7b Douglas Gilbert 2014-11-24  7886  	devip = (struct sdebug_dev_info *)sdp->hostdata;
f46eb0e9fc763b Douglas Gilbert 2016-04-25  7887  	if (unlikely(!devip)) {
f46eb0e9fc763b Douglas Gilbert 2016-04-25  7888  		devip = find_build_dev_info(sdp);
c2248fc974df7b Douglas Gilbert 2014-11-24  7889  		if (NULL == devip)
f46eb0e9fc763b Douglas Gilbert 2016-04-25  7890  			goto err_out;
c2248fc974df7b Douglas Gilbert 2014-11-24  7891  	}
3f07ff40cb2457 Wenchao Hao     2023-09-22  7892  
3f07ff40cb2457 Wenchao Hao     2023-09-22  7893  	if (sdebug_timeout_cmd(scp)) {
3f07ff40cb2457 Wenchao Hao     2023-09-22  7894  		scmd_printk(KERN_INFO, scp, "timeout command 0x%x\n", opcode);
3f07ff40cb2457 Wenchao Hao     2023-09-22  7895  		return 0;
3f07ff40cb2457 Wenchao Hao     2023-09-22  7896  	}
3f07ff40cb2457 Wenchao Hao     2023-09-22  7897  
929aad8ff0578d Wenchao Hao     2023-09-22  7898  	ret = sdebug_fail_queue_cmd(scp);
929aad8ff0578d Wenchao Hao     2023-09-22  7899  	if (ret) {
929aad8ff0578d Wenchao Hao     2023-09-22  7900  		scmd_printk(KERN_INFO, scp, "fail queue command 0x%x with 0x%x\n",
929aad8ff0578d Wenchao Hao     2023-09-22  7901  				opcode, ret);
929aad8ff0578d Wenchao Hao     2023-09-22  7902  		return ret;
929aad8ff0578d Wenchao Hao     2023-09-22  7903  	}
929aad8ff0578d Wenchao Hao     2023-09-22  7904  
cc36ffafc0f7e6 Wenchao Hao     2023-09-22  7905  	if (sdebug_fail_cmd(scp, &ret, &err)) {
cc36ffafc0f7e6 Wenchao Hao     2023-09-22  7906  		scmd_printk(KERN_INFO, scp,
cc36ffafc0f7e6 Wenchao Hao     2023-09-22  7907  			"fail command 0x%x with hostbyte=0x%x, "
cc36ffafc0f7e6 Wenchao Hao     2023-09-22  7908  			"driverbyte=0x%x, statusbyte=0x%x, "
cc36ffafc0f7e6 Wenchao Hao     2023-09-22  7909  			"sense_key=0x%x, asc=0x%x, asq=0x%x\n",
cc36ffafc0f7e6 Wenchao Hao     2023-09-22  7910  			opcode, err.host_byte, err.driver_byte,
cc36ffafc0f7e6 Wenchao Hao     2023-09-22  7911  			err.status_byte, err.sense_key, err.asc, err.asq);
cc36ffafc0f7e6 Wenchao Hao     2023-09-22 @7912  		return ret;

This returns zero but it should be an error code.

cc36ffafc0f7e6 Wenchao Hao     2023-09-22  7913  	}
cc36ffafc0f7e6 Wenchao Hao     2023-09-22  7914  
3a90a63d02b8b7 Douglas Gilbert 2020-07-12  7915  	if (unlikely(inject_now && !atomic_read(&sdeb_inject_pending)))
3a90a63d02b8b7 Douglas Gilbert 2020-07-12  7916  		atomic_set(&sdeb_inject_pending, 1);
3a90a63d02b8b7 Douglas Gilbert 2020-07-12  7917  
c2248fc974df7b Douglas Gilbert 2014-11-24  7918  	na = oip->num_attached;
c2248fc974df7b Douglas Gilbert 2014-11-24  7919  	r_pfp = oip->pfp;
c2248fc974df7b Douglas Gilbert 2014-11-24  7920  	if (na) {	/* multiple commands with this opcode */
c2248fc974df7b Douglas Gilbert 2014-11-24  7921  		r_oip = oip;

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

