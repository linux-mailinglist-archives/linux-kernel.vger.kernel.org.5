Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7683757F69
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 16:26:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232655AbjGRO0c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 10:26:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbjGRO0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 10:26:30 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17ED8170F;
        Tue, 18 Jul 2023 07:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689690388; x=1721226388;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=z8jTa5AftVwjf24Wnb/QfpwVzE14cz3NHaUKq4754Xs=;
  b=Q03LgkLOYBygQsiaSo5OsUIXikh45oTDUQgm30GAkKipEvODG4guY0ka
   KywBnhV5y+yMW8OzqfW6QnDYMlnLnggWuH6lNpRQ7uBiPMZlZhHelJ/DA
   Z0ie19TiD94IZvh1w9a1iccbv5vAfNfaq2Z/dlwFWkAfm+MbC8yNb30dF
   dFJkj4E9uB6DoByD/gKOEntA0NRVuSt4879pzFc6lYZlBqpkcb1dcknhE
   IU+WDiVw0aqk+sAntxayZ6+lhvgLfn89k/EOKA0sV3KEYsJ2nkJ5sjPog
   DWTGNqOIwCLOk+2F3cX8dTQr0WZaWuCveR+aLDaRkdyzbcwDUuRRHhhT2
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="366262061"
X-IronPort-AV: E=Sophos;i="6.01,214,1684825200"; 
   d="scan'208";a="366262061"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2023 07:26:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="726953591"
X-IronPort-AV: E=Sophos;i="6.01,214,1684825200"; 
   d="scan'208";a="726953591"
Received: from lkp-server02.sh.intel.com (HELO 36946fcf73d7) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 18 Jul 2023 07:26:24 -0700
Received: from kbuild by 36946fcf73d7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qLlee-0000eB-1G;
        Tue, 18 Jul 2023 14:26:23 +0000
Date:   Tue, 18 Jul 2023 22:25:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Steve French <stfrench@microsoft.com>,
        linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
        linux-kernel@vger.kernel.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Paulo Alcantara <pc@manguebit.com>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Shyam Prasad N <sprasad@microsoft.com>,
        Tom Talpey <tom@talpey.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/1] smb: client: Rework memcpy() to avoid compilation
 error
Message-ID: <202307182203.py4XAFoE-lkp@intel.com>
References: <20230717100003.11824-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230717100003.11824-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

kernel test robot noticed the following build errors:

[auto build test ERROR on cifs/for-next]
[also build test ERROR on linus/master v6.5-rc2 next-20230718]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Andy-Shevchenko/smb-client-Rework-memcpy-to-avoid-compilation-error/20230718-195935
base:   git://git.samba.org/sfrench/cifs-2.6.git for-next
patch link:    https://lore.kernel.org/r/20230717100003.11824-1-andriy.shevchenko%40linux.intel.com
patch subject: [PATCH v1 1/1] smb: client: Rework memcpy() to avoid compilation error
config: i386-randconfig-r013-20230718 (https://download.01.org/0day-ci/archive/20230718/202307182203.py4XAFoE-lkp@intel.com/config)
compiler: clang version 15.0.7 (https://github.com/llvm/llvm-project.git 8dfdcc7b7bf66834a761bd8de445840ef68e4d1a)
reproduce: (https://download.01.org/0day-ci/archive/20230718/202307182203.py4XAFoE-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307182203.py4XAFoE-lkp@intel.com/

All errors (new ones prefixed by >>):

>> fs/smb/client/cifssmb.c:1252:8: error: no member named 'FileAttributes' in 'FILE_ALL_INFO'; did you mean 'Attributes'?
                   buf->FileAttributes = rsp->FileAttributes;
                        ^~~~~~~~~~~~~~
                        Attributes
   fs/smb/client/cifspdu.h:2271:9: note: 'Attributes' declared here
           __le32 Attributes;
                  ^
   1 error generated.


vim +1252 fs/smb/client/cifssmb.c

  1140	
  1141	int
  1142	CIFS_open(const unsigned int xid, struct cifs_open_parms *oparms, int *oplock,
  1143		  FILE_ALL_INFO *buf)
  1144	{
  1145		int rc;
  1146		OPEN_REQ *req = NULL;
  1147		OPEN_RSP *rsp = NULL;
  1148		int bytes_returned;
  1149		int name_len;
  1150		__u16 count;
  1151		struct cifs_sb_info *cifs_sb = oparms->cifs_sb;
  1152		struct cifs_tcon *tcon = oparms->tcon;
  1153		int remap = cifs_remap(cifs_sb);
  1154		const struct nls_table *nls = cifs_sb->local_nls;
  1155		int create_options = oparms->create_options;
  1156		int desired_access = oparms->desired_access;
  1157		int disposition = oparms->disposition;
  1158		const char *path = oparms->path;
  1159	
  1160	openRetry:
  1161		rc = smb_init(SMB_COM_NT_CREATE_ANDX, 24, tcon, (void **)&req,
  1162			      (void **)&rsp);
  1163		if (rc)
  1164			return rc;
  1165	
  1166		/* no commands go after this */
  1167		req->AndXCommand = 0xFF;
  1168	
  1169		if (req->hdr.Flags2 & SMBFLG2_UNICODE) {
  1170			/* account for one byte pad to word boundary */
  1171			count = 1;
  1172			name_len = cifsConvertToUTF16((__le16 *)(req->fileName + 1),
  1173						      path, PATH_MAX, nls, remap);
  1174			/* trailing null */
  1175			name_len++;
  1176			name_len *= 2;
  1177			req->NameLength = cpu_to_le16(name_len);
  1178		} else {
  1179			/* BB improve check for buffer overruns BB */
  1180			/* no pad */
  1181			count = 0;
  1182			name_len = copy_path_name(req->fileName, path);
  1183			req->NameLength = cpu_to_le16(name_len);
  1184		}
  1185	
  1186		if (*oplock & REQ_OPLOCK)
  1187			req->OpenFlags = cpu_to_le32(REQ_OPLOCK);
  1188		else if (*oplock & REQ_BATCHOPLOCK)
  1189			req->OpenFlags = cpu_to_le32(REQ_BATCHOPLOCK);
  1190	
  1191		req->DesiredAccess = cpu_to_le32(desired_access);
  1192		req->AllocationSize = 0;
  1193	
  1194		/*
  1195		 * Set file as system file if special file such as fifo and server
  1196		 * expecting SFU style and no Unix extensions.
  1197		 */
  1198		if (create_options & CREATE_OPTION_SPECIAL)
  1199			req->FileAttributes = cpu_to_le32(ATTR_SYSTEM);
  1200		else
  1201			req->FileAttributes = cpu_to_le32(ATTR_NORMAL);
  1202	
  1203		/*
  1204		 * XP does not handle ATTR_POSIX_SEMANTICS but it helps speed up case
  1205		 * sensitive checks for other servers such as Samba.
  1206		 */
  1207		if (tcon->ses->capabilities & CAP_UNIX)
  1208			req->FileAttributes |= cpu_to_le32(ATTR_POSIX_SEMANTICS);
  1209	
  1210		if (create_options & CREATE_OPTION_READONLY)
  1211			req->FileAttributes |= cpu_to_le32(ATTR_READONLY);
  1212	
  1213		req->ShareAccess = cpu_to_le32(FILE_SHARE_ALL);
  1214		req->CreateDisposition = cpu_to_le32(disposition);
  1215		req->CreateOptions = cpu_to_le32(create_options & CREATE_OPTIONS_MASK);
  1216	
  1217		/* BB Expirement with various impersonation levels and verify */
  1218		req->ImpersonationLevel = cpu_to_le32(SECURITY_IMPERSONATION);
  1219		req->SecurityFlags = SECURITY_CONTEXT_TRACKING|SECURITY_EFFECTIVE_ONLY;
  1220	
  1221		count += name_len;
  1222		inc_rfc1001_len(req, count);
  1223	
  1224		req->ByteCount = cpu_to_le16(count);
  1225		rc = SendReceive(xid, tcon->ses, (struct smb_hdr *)req,
  1226				 (struct smb_hdr *)rsp, &bytes_returned, 0);
  1227		cifs_stats_inc(&tcon->stats.cifs_stats.num_opens);
  1228		if (rc) {
  1229			cifs_dbg(FYI, "Error in Open = %d\n", rc);
  1230			cifs_buf_release(req);
  1231			if (rc == -EAGAIN)
  1232				goto openRetry;
  1233			return rc;
  1234		}
  1235	
  1236		/* 1 byte no need to le_to_cpu */
  1237		*oplock = rsp->OplockLevel;
  1238		/* cifs fid stays in le */
  1239		oparms->fid->netfid = rsp->Fid;
  1240		oparms->fid->access = desired_access;
  1241	
  1242		/* Let caller know file was created so we can set the mode. */
  1243		/* Do we care about the CreateAction in any other cases? */
  1244		if (cpu_to_le32(FILE_CREATE) == rsp->CreateAction)
  1245			*oplock |= CIFS_CREATE_ACTION;
  1246	
  1247		if (buf) {
  1248			buf->CreationTime = rsp->CreationTime;
  1249			buf->LastAccessTime = rsp->LastAccessTime;
  1250			buf->LastWriteTime = rsp->LastWriteTime;
  1251			buf->ChangeTime = rsp->ChangeTime;
> 1252			buf->FileAttributes = rsp->FileAttributes;
  1253			/* the file_info buf is endian converted by caller */
  1254			buf->AllocationSize = rsp->AllocationSize;
  1255			buf->EndOfFile = rsp->EndOfFile;
  1256			buf->NumberOfLinks = cpu_to_le32(1);
  1257			buf->DeletePending = 0;
  1258		}
  1259	
  1260		cifs_buf_release(req);
  1261		return rc;
  1262	}
  1263	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
