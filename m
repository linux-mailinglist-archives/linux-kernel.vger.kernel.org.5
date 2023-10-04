Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC35D7B79EE
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 10:22:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241667AbjJDIWz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 04:22:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241628AbjJDIWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 04:22:52 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC001AD
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 01:22:47 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-406650da82bso17210945e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 01:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696407766; x=1697012566; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7lASRZKty5ExpIf8a7SkpCZKAXewoWwnd7oDE42K+tI=;
        b=YN4gWZp4rC21wuVYgVLqAdH5ZzG7GiAVyZp22nipmZu7X8HIdiHzKW3hbTgwxlQ1gC
         enYgp/b+Jga8lHsmSqnMfSDTkqfCgFuVyX34iJ1PEvWITyNAxehwzPycPl9asJEtpqLH
         7bk06O8tPLLoCQTfX6CUp+2W88/kC8VdRGs2iVKsbcgsxzkIBhGV//pmLQ97LHRjJtq+
         +f8sGekmRF3CRuHCzUxVjnlLz0QgcjcJX05sQybxwI+Gt5K7R5dIjoRgzvMHDSU4x7uv
         /skgW0IGHuIYQlquI70zuqfH2cqYXCQo07VhJf+IVP6LPlnW6gDnyx4xEy5t58TAka8i
         C8Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696407766; x=1697012566;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7lASRZKty5ExpIf8a7SkpCZKAXewoWwnd7oDE42K+tI=;
        b=LZ3Cfn4B8DX+izl0Zx/Z44qAOcSEpvDMQgxzFvzi/5BqIGIJRx0z/H6XZske7E7TM+
         8RI7TlZZkWyeWE/uBXaLMLGYF6dDczI1KrnlweXOebxBY5L0PfYMpnwWET1yaKBk8Jdx
         mlOCAvpblzGDThDOPlmOTnj2fpBY4RqJJJ4HTwXEUR83NaLAeFmDh4UWo5Edw3hxlz/V
         2+N4PSeL/Vn8pCCLdVP9jEaj4v/ECx27BhORgQxrft99lS6yjMe2jzbEeCV4igSzclIe
         2SAt4H3AAvibGeidvRgL6dzvqPPcm9H/YpwW2823t3l1NStZXwYXuHO2u/CbHUxifd87
         hWbQ==
X-Gm-Message-State: AOJu0Yye4bsVmA4VQ58piiSEzRPRrTwkHv5ecdb3AEIIA3zK9yjJ0gRd
        nYmCmCQN2eV1Wo/nKOSlk2EWVQ==
X-Google-Smtp-Source: AGHT+IFotsPOvnw4M9o3Z4Nbt8NwHjr923dBWIoUmKFWH9Seq4US3CR732X8UO2cZe90jcCzi/nZ2w==
X-Received: by 2002:a1c:7910:0:b0:401:c0ef:c287 with SMTP id l16-20020a1c7910000000b00401c0efc287mr1875403wme.27.1696407766324;
        Wed, 04 Oct 2023 01:22:46 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id k10-20020a7bc40a000000b003fc06169ab3sm900469wmi.20.2023.10.04.01.22.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 01:22:45 -0700 (PDT)
Date:   Wed, 4 Oct 2023 11:22:43 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     oe-kbuild@lists.linux.dev, Dan Williams <dan.j.williams@intel.com>,
        linux-coco@lists.linux.dev
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        Borislav Petkov <bp@alien8.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Dionna Glaze <dionnaglaze@google.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>,
        peterz@infradead.org, linux-kernel@vger.kernel.org, x86@kernel.org,
        dave.hansen@linux.intel.com
Subject: Re: [PATCH v4 5/6] virt: sevguest: Add TSM_REPORTS support for
 SNP_{GET, GET_EXT}_REPORT
Message-ID: <6cc8a021-a32a-4732-b7a0-eb3a6dbb5ee2@kadam.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <169570184829.596431.15991881056638719011.stgit@dwillia2-xfh.jf.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

kernel test robot noticed the following build warnings:

url:    https://github.com/intel-lab-lkp/linux/commits/Dan-Williams/virt-coco-Add-a-coco-Makefile-and-coco-Kconfig/20230926-121843
base:   6465e260f48790807eef06b583b38ca9789b6072
patch link:    https://lore.kernel.org/r/169570184829.596431.15991881056638719011.stgit%40dwillia2-xfh.jf.intel.com
patch subject: [PATCH v4 5/6] virt: sevguest: Add TSM_REPORTS support for SNP_{GET, GET_EXT}_REPORT
config: x86_64-randconfig-161-20231002 (https://download.01.org/0day-ci/archive/20231003/202310030341.zaOu0ew0-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231003/202310030341.zaOu0ew0-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202310030341.zaOu0ew0-lkp@intel.com/

smatch warnings:
drivers/virt/coco/sev-guest/sev-guest.c:853 sev_report_new() error: uninitialized symbol 'certs_size'.

vim +/certs_size +853 drivers/virt/coco/sev-guest/sev-guest.c

80013405d5b7c6 Dan Williams 2023-09-25  778  static int sev_report_new(struct tsm_report *report, void *data)
80013405d5b7c6 Dan Williams 2023-09-25  779  {
80013405d5b7c6 Dan Williams 2023-09-25  780  	static const struct snp_msg_cert_entry zero_ent = { 0 };
80013405d5b7c6 Dan Williams 2023-09-25  781  	struct tsm_desc *desc = &report->desc;
80013405d5b7c6 Dan Williams 2023-09-25  782  	struct snp_guest_dev *snp_dev = data;
80013405d5b7c6 Dan Williams 2023-09-25  783  	struct snp_msg_report_resp_hdr hdr;
80013405d5b7c6 Dan Williams 2023-09-25  784  	const int report_size = SZ_4K;
80013405d5b7c6 Dan Williams 2023-09-25  785  	const int ext_size = SZ_16K;
80013405d5b7c6 Dan Williams 2023-09-25  786  	int ret, size = report_size + ext_size;
80013405d5b7c6 Dan Williams 2023-09-25  787  	int certs_size, cert_count, i, offset;
80013405d5b7c6 Dan Williams 2023-09-25  788  	u8 *certs_address;
80013405d5b7c6 Dan Williams 2023-09-25  789  
80013405d5b7c6 Dan Williams 2023-09-25  790  	if (desc->inblob_len != 64)
80013405d5b7c6 Dan Williams 2023-09-25  791  		return -EINVAL;
80013405d5b7c6 Dan Williams 2023-09-25  792  
80013405d5b7c6 Dan Williams 2023-09-25  793  	void *buf __free(kvfree) = kvzalloc(size, GFP_KERNEL);
80013405d5b7c6 Dan Williams 2023-09-25  794  	if (!buf)
80013405d5b7c6 Dan Williams 2023-09-25  795  		return -ENOMEM;
80013405d5b7c6 Dan Williams 2023-09-25  796  
80013405d5b7c6 Dan Williams 2023-09-25  797  	guard(mutex)(&snp_cmd_mutex);

Hoho.  Need guard stuff and no warnings generated.  Perhaps I have added
all the new unlock functions.  :)

80013405d5b7c6 Dan Williams 2023-09-25  798  	certs_address = buf + report_size;
80013405d5b7c6 Dan Williams 2023-09-25  799  	struct snp_ext_report_req ext_req = {
80013405d5b7c6 Dan Williams 2023-09-25  800  		.data = { .vmpl = desc->privlevel },
80013405d5b7c6 Dan Williams 2023-09-25  801  		.certs_address = (__u64)certs_address,
80013405d5b7c6 Dan Williams 2023-09-25  802  		.certs_len = ext_size,
80013405d5b7c6 Dan Williams 2023-09-25  803  	};
80013405d5b7c6 Dan Williams 2023-09-25  804  	memcpy(&ext_req.data.user_data, desc->inblob, desc->inblob_len);
80013405d5b7c6 Dan Williams 2023-09-25  805  
80013405d5b7c6 Dan Williams 2023-09-25  806  	struct snp_guest_request_ioctl input = {
80013405d5b7c6 Dan Williams 2023-09-25  807  		.msg_version = 1,
80013405d5b7c6 Dan Williams 2023-09-25  808  		.req_data = (__u64)&ext_req,
80013405d5b7c6 Dan Williams 2023-09-25  809  		.resp_data = (__u64)buf,
80013405d5b7c6 Dan Williams 2023-09-25  810  	};
80013405d5b7c6 Dan Williams 2023-09-25  811  	struct snp_req_resp io = {
80013405d5b7c6 Dan Williams 2023-09-25  812  		.req_data = KERNEL_SOCKPTR(&ext_req),
80013405d5b7c6 Dan Williams 2023-09-25  813  		.resp_data = KERNEL_SOCKPTR(buf),
80013405d5b7c6 Dan Williams 2023-09-25  814  	};
80013405d5b7c6 Dan Williams 2023-09-25  815  
80013405d5b7c6 Dan Williams 2023-09-25  816  	ret = get_ext_report(snp_dev, &input, &io);
80013405d5b7c6 Dan Williams 2023-09-25  817  
80013405d5b7c6 Dan Williams 2023-09-25  818  	if (ret)
80013405d5b7c6 Dan Williams 2023-09-25  819  		return ret;
80013405d5b7c6 Dan Williams 2023-09-25  820  
80013405d5b7c6 Dan Williams 2023-09-25  821  	memcpy(&hdr, buf, sizeof(hdr));
80013405d5b7c6 Dan Williams 2023-09-25  822  	if (hdr.status == SNP_REPORT_INVALID_PARAM)
80013405d5b7c6 Dan Williams 2023-09-25  823  		return -EINVAL;
80013405d5b7c6 Dan Williams 2023-09-25  824  	if (hdr.status == SNP_REPORT_INVALID_KEY_SEL)
80013405d5b7c6 Dan Williams 2023-09-25  825  		return -EINVAL;
80013405d5b7c6 Dan Williams 2023-09-25  826  	if (hdr.status)
80013405d5b7c6 Dan Williams 2023-09-25  827  		return -ENXIO;
80013405d5b7c6 Dan Williams 2023-09-25  828  	if ((hdr.report_size + sizeof(hdr)) > report_size)
80013405d5b7c6 Dan Williams 2023-09-25  829  		return -ENOMEM;
80013405d5b7c6 Dan Williams 2023-09-25  830  
80013405d5b7c6 Dan Williams 2023-09-25  831  	void *rbuf __free(kvfree) = kvzalloc(hdr.report_size, GFP_KERNEL);
80013405d5b7c6 Dan Williams 2023-09-25  832  	if (!rbuf)
80013405d5b7c6 Dan Williams 2023-09-25  833  		return -ENOMEM;
80013405d5b7c6 Dan Williams 2023-09-25  834  
80013405d5b7c6 Dan Williams 2023-09-25  835  	memcpy(rbuf, buf + sizeof(hdr), hdr.report_size);
80013405d5b7c6 Dan Williams 2023-09-25  836  	report->outblob = no_free_ptr(rbuf);
80013405d5b7c6 Dan Williams 2023-09-25  837  	report->outblob_len = hdr.report_size;
80013405d5b7c6 Dan Williams 2023-09-25  838  
80013405d5b7c6 Dan Williams 2023-09-25  839  	for (i = 0; i < ext_size / sizeof(struct snp_msg_cert_entry); i++) {
80013405d5b7c6 Dan Williams 2023-09-25  840  		struct snp_msg_cert_entry *certs = buf + report_size;
80013405d5b7c6 Dan Williams 2023-09-25  841  
80013405d5b7c6 Dan Williams 2023-09-25  842  		if (memcmp(&certs[i], &zero_ent, sizeof(zero_ent)) == 0)
80013405d5b7c6 Dan Williams 2023-09-25  843  			break;
80013405d5b7c6 Dan Williams 2023-09-25  844  		certs_size += certs[i].length;

certs_size needs to be initialized to zero.

80013405d5b7c6 Dan Williams 2023-09-25  845  	}
80013405d5b7c6 Dan Williams 2023-09-25  846  	cert_count = i;
80013405d5b7c6 Dan Williams 2023-09-25  847  
80013405d5b7c6 Dan Williams 2023-09-25  848  	/* No certs to report */
80013405d5b7c6 Dan Williams 2023-09-25  849  	if (cert_count == 0)
80013405d5b7c6 Dan Williams 2023-09-25  850  		return 0;
80013405d5b7c6 Dan Williams 2023-09-25  851  
80013405d5b7c6 Dan Williams 2023-09-25  852  	/* sanity check that the entire certs table with metadata fits */
80013405d5b7c6 Dan Williams 2023-09-25 @853  	if ((cert_count + 1) * sizeof(zero_ent) + certs_size > ext_size)
80013405d5b7c6 Dan Williams 2023-09-25  854  		return -ENXIO;
80013405d5b7c6 Dan Williams 2023-09-25  855  
80013405d5b7c6 Dan Williams 2023-09-25  856  	void *cbuf __free(kvfree) = kvzalloc(certs_size, GFP_KERNEL);
80013405d5b7c6 Dan Williams 2023-09-25  857  	if (!cbuf)
80013405d5b7c6 Dan Williams 2023-09-25  858  		return -ENOMEM;
80013405d5b7c6 Dan Williams 2023-09-25  859  
80013405d5b7c6 Dan Williams 2023-09-25  860  	/* Concatenate returned certs */
80013405d5b7c6 Dan Williams 2023-09-25  861  	for (i = 0, offset = 0; i < cert_count; i++) {
80013405d5b7c6 Dan Williams 2023-09-25  862  		struct snp_msg_cert_entry *certs = buf + report_size;
80013405d5b7c6 Dan Williams 2023-09-25  863  
80013405d5b7c6 Dan Williams 2023-09-25  864  		memcpy(cbuf + offset, certs_address + certs[i].offset, certs[i].length);
80013405d5b7c6 Dan Williams 2023-09-25  865  		offset += certs[i].length;
80013405d5b7c6 Dan Williams 2023-09-25  866  	}
80013405d5b7c6 Dan Williams 2023-09-25  867  
80013405d5b7c6 Dan Williams 2023-09-25  868  	report->certs = no_free_ptr(cbuf);
80013405d5b7c6 Dan Williams 2023-09-25  869  	report->certs_len = certs_size;
80013405d5b7c6 Dan Williams 2023-09-25  870  
80013405d5b7c6 Dan Williams 2023-09-25  871  	return 0;
80013405d5b7c6 Dan Williams 2023-09-25  872  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

