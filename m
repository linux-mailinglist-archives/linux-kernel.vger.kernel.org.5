Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A32175DA41
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 08:05:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbjGVFsN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 01:48:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjGVFsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 01:48:11 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 549832737
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 22:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690004889; x=1721540889;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Wo5w0D8UKnXAmnn1P2N6PbdaZSjTjk4IjsG3dK3tDAo=;
  b=eD2Q6jwWjsSHckyODK3WnrpzEkhBaqVBCHAaaWEf7uO3/1pBuYcv35UP
   mrykg9e4sMtE2OhzdpWQtLaI1VJ6B2hcVYTKzQIh0CeAfSLpXlfH8Tl4z
   ns7h/1NRdUVGK9kWWqAZ6e8dGDk8pnJqkuKP+PMR2DJgJoEY7d4rDjDZR
   AD/4gdWfxkP8krkKByjYdkvFlQR18IBLpRPqZtAEwK1yZv3pKR8SErlCy
   1T+IV7zSnjiOXW2YEl8FQTgRlLuLoIQrbH6NM/iYXEGqs5VHVx0i5S3YJ
   Q97Zd3fNHse76+gs9VAsQTiZuc1faE8SgrNv6+XWOH5m6TkenUaiwk8RW
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10778"; a="453544191"
X-IronPort-AV: E=Sophos;i="6.01,223,1684825200"; 
   d="scan'208";a="453544191"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2023 22:48:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10778"; a="675267644"
X-IronPort-AV: E=Sophos;i="6.01,223,1684825200"; 
   d="scan'208";a="675267644"
Received: from lkp-server02.sh.intel.com (HELO 36946fcf73d7) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 21 Jul 2023 22:48:06 -0700
Received: from kbuild by 36946fcf73d7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qN5TJ-00082B-2I;
        Sat, 22 Jul 2023 05:48:05 +0000
Date:   Sat, 22 Jul 2023 13:47:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>
Subject: kernel/bpf/verifier.c:8189:12: warning: stack frame size (1072)
 exceeds limit (1024) in 'check_kfunc_args'
Message-ID: <202307221337.7nbC2QqZ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kumar,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   d192f5382581d972c4ae1b4d72e0b59b34cadeb9
commit: a50388dbb328a4267c2b91ad4aefe81b08e49b2d bpf: Support constant scalar arguments for kfuncs
date:   8 months ago
config: riscv-randconfig-r022-20230722 (https://download.01.org/0day-ci/archive/20230722/202307221337.7nbC2QqZ-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project.git f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce: (https://download.01.org/0day-ci/archive/20230722/202307221337.7nbC2QqZ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307221337.7nbC2QqZ-lkp@intel.com/

All warnings (new ones prefixed by >>):

   kernel/bpf/verifier.c:14702:12: warning: stack frame size (1184) exceeds limit (1024) in 'do_misc_fixups' [-Wframe-larger-than]
   static int do_misc_fixups(struct bpf_verifier_env *env)
              ^
   kernel/bpf/verifier.c:12936:12: warning: stack frame size (1712) exceeds limit (1024) in 'do_check' [-Wframe-larger-than]
   static int do_check(struct bpf_verifier_env *env)
              ^
>> kernel/bpf/verifier.c:8189:12: warning: stack frame size (1072) exceeds limit (1024) in 'check_kfunc_args' [-Wframe-larger-than]
   static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_arg_meta *meta)
              ^
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   fatal error: too many errors emitted, stopping now [-ferror-limit=]
   3 warnings and 20 errors generated.


vim +/check_kfunc_args +8189 kernel/bpf/verifier.c

00b85860feb809 Kumar Kartikeya Dwivedi 2022-11-18  8188  
00b85860feb809 Kumar Kartikeya Dwivedi 2022-11-18 @8189  static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_arg_meta *meta)
00b85860feb809 Kumar Kartikeya Dwivedi 2022-11-18  8190  {
00b85860feb809 Kumar Kartikeya Dwivedi 2022-11-18  8191  	const char *func_name = meta->func_name, *ref_tname;
00b85860feb809 Kumar Kartikeya Dwivedi 2022-11-18  8192  	const struct btf *btf = meta->btf;
00b85860feb809 Kumar Kartikeya Dwivedi 2022-11-18  8193  	const struct btf_param *args;
00b85860feb809 Kumar Kartikeya Dwivedi 2022-11-18  8194  	u32 i, nargs;
00b85860feb809 Kumar Kartikeya Dwivedi 2022-11-18  8195  	int ret;
00b85860feb809 Kumar Kartikeya Dwivedi 2022-11-18  8196  
00b85860feb809 Kumar Kartikeya Dwivedi 2022-11-18  8197  	args = (const struct btf_param *)(meta->func_proto + 1);
00b85860feb809 Kumar Kartikeya Dwivedi 2022-11-18  8198  	nargs = btf_type_vlen(meta->func_proto);
00b85860feb809 Kumar Kartikeya Dwivedi 2022-11-18  8199  	if (nargs > MAX_BPF_FUNC_REG_ARGS) {
00b85860feb809 Kumar Kartikeya Dwivedi 2022-11-18  8200  		verbose(env, "Function %s has %d > %d args\n", func_name, nargs,
00b85860feb809 Kumar Kartikeya Dwivedi 2022-11-18  8201  			MAX_BPF_FUNC_REG_ARGS);
00b85860feb809 Kumar Kartikeya Dwivedi 2022-11-18  8202  		return -EINVAL;
00b85860feb809 Kumar Kartikeya Dwivedi 2022-11-18  8203  	}
00b85860feb809 Kumar Kartikeya Dwivedi 2022-11-18  8204  
00b85860feb809 Kumar Kartikeya Dwivedi 2022-11-18  8205  	/* Check that BTF function arguments match actual types that the
00b85860feb809 Kumar Kartikeya Dwivedi 2022-11-18  8206  	 * verifier sees.
00b85860feb809 Kumar Kartikeya Dwivedi 2022-11-18  8207  	 */
00b85860feb809 Kumar Kartikeya Dwivedi 2022-11-18  8208  	for (i = 0; i < nargs; i++) {
00b85860feb809 Kumar Kartikeya Dwivedi 2022-11-18  8209  		struct bpf_reg_state *regs = cur_regs(env), *reg = &regs[i + 1];
00b85860feb809 Kumar Kartikeya Dwivedi 2022-11-18  8210  		const struct btf_type *t, *ref_t, *resolve_ret;
00b85860feb809 Kumar Kartikeya Dwivedi 2022-11-18  8211  		enum bpf_arg_type arg_type = ARG_DONTCARE;
00b85860feb809 Kumar Kartikeya Dwivedi 2022-11-18  8212  		u32 regno = i + 1, ref_id, type_size;
00b85860feb809 Kumar Kartikeya Dwivedi 2022-11-18  8213  		bool is_ret_buf_sz = false;
00b85860feb809 Kumar Kartikeya Dwivedi 2022-11-18  8214  		int kf_arg_type;
00b85860feb809 Kumar Kartikeya Dwivedi 2022-11-18  8215  
00b85860feb809 Kumar Kartikeya Dwivedi 2022-11-18  8216  		t = btf_type_skip_modifiers(btf, args[i].type, NULL);
00b85860feb809 Kumar Kartikeya Dwivedi 2022-11-18  8217  		if (btf_type_is_scalar(t)) {
00b85860feb809 Kumar Kartikeya Dwivedi 2022-11-18  8218  			if (reg->type != SCALAR_VALUE) {
00b85860feb809 Kumar Kartikeya Dwivedi 2022-11-18  8219  				verbose(env, "R%d is not a scalar\n", regno);
00b85860feb809 Kumar Kartikeya Dwivedi 2022-11-18  8220  				return -EINVAL;
00b85860feb809 Kumar Kartikeya Dwivedi 2022-11-18  8221  			}
a50388dbb328a4 Kumar Kartikeya Dwivedi 2022-11-18  8222  
a50388dbb328a4 Kumar Kartikeya Dwivedi 2022-11-18  8223  			if (is_kfunc_arg_constant(meta->btf, &args[i])) {
a50388dbb328a4 Kumar Kartikeya Dwivedi 2022-11-18  8224  				if (meta->arg_constant.found) {
a50388dbb328a4 Kumar Kartikeya Dwivedi 2022-11-18  8225  					verbose(env, "verifier internal error: only one constant argument permitted\n");
a50388dbb328a4 Kumar Kartikeya Dwivedi 2022-11-18  8226  					return -EFAULT;
a50388dbb328a4 Kumar Kartikeya Dwivedi 2022-11-18  8227  				}
a50388dbb328a4 Kumar Kartikeya Dwivedi 2022-11-18  8228  				if (!tnum_is_const(reg->var_off)) {
a50388dbb328a4 Kumar Kartikeya Dwivedi 2022-11-18  8229  					verbose(env, "R%d must be a known constant\n", regno);
a50388dbb328a4 Kumar Kartikeya Dwivedi 2022-11-18  8230  					return -EINVAL;
a50388dbb328a4 Kumar Kartikeya Dwivedi 2022-11-18  8231  				}
a50388dbb328a4 Kumar Kartikeya Dwivedi 2022-11-18  8232  				ret = mark_chain_precision(env, regno);
a50388dbb328a4 Kumar Kartikeya Dwivedi 2022-11-18  8233  				if (ret < 0)
a50388dbb328a4 Kumar Kartikeya Dwivedi 2022-11-18  8234  					return ret;
a50388dbb328a4 Kumar Kartikeya Dwivedi 2022-11-18  8235  				meta->arg_constant.found = true;
a50388dbb328a4 Kumar Kartikeya Dwivedi 2022-11-18  8236  				meta->arg_constant.value = reg->var_off.value;
a50388dbb328a4 Kumar Kartikeya Dwivedi 2022-11-18  8237  			} else if (is_kfunc_arg_scalar_with_name(btf, &args[i], "rdonly_buf_size")) {
00b85860feb809 Kumar Kartikeya Dwivedi 2022-11-18  8238  				meta->r0_rdonly = true;
00b85860feb809 Kumar Kartikeya Dwivedi 2022-11-18  8239  				is_ret_buf_sz = true;
00b85860feb809 Kumar Kartikeya Dwivedi 2022-11-18  8240  			} else if (is_kfunc_arg_scalar_with_name(btf, &args[i], "rdwr_buf_size")) {
00b85860feb809 Kumar Kartikeya Dwivedi 2022-11-18  8241  				is_ret_buf_sz = true;
00b85860feb809 Kumar Kartikeya Dwivedi 2022-11-18  8242  			}
00b85860feb809 Kumar Kartikeya Dwivedi 2022-11-18  8243  
00b85860feb809 Kumar Kartikeya Dwivedi 2022-11-18  8244  			if (is_ret_buf_sz) {
00b85860feb809 Kumar Kartikeya Dwivedi 2022-11-18  8245  				if (meta->r0_size) {
00b85860feb809 Kumar Kartikeya Dwivedi 2022-11-18  8246  					verbose(env, "2 or more rdonly/rdwr_buf_size parameters for kfunc");
00b85860feb809 Kumar Kartikeya Dwivedi 2022-11-18  8247  					return -EINVAL;
00b85860feb809 Kumar Kartikeya Dwivedi 2022-11-18  8248  				}
00b85860feb809 Kumar Kartikeya Dwivedi 2022-11-18  8249  
00b85860feb809 Kumar Kartikeya Dwivedi 2022-11-18  8250  				if (!tnum_is_const(reg->var_off)) {
00b85860feb809 Kumar Kartikeya Dwivedi 2022-11-18  8251  					verbose(env, "R%d is not a const\n", regno);
00b85860feb809 Kumar Kartikeya Dwivedi 2022-11-18  8252  					return -EINVAL;
00b85860feb809 Kumar Kartikeya Dwivedi 2022-11-18  8253  				}
00b85860feb809 Kumar Kartikeya Dwivedi 2022-11-18  8254  
00b85860feb809 Kumar Kartikeya Dwivedi 2022-11-18  8255  				meta->r0_size = reg->var_off.value;
00b85860feb809 Kumar Kartikeya Dwivedi 2022-11-18  8256  				ret = mark_chain_precision(env, regno);
00b85860feb809 Kumar Kartikeya Dwivedi 2022-11-18  8257  				if (ret)
00b85860feb809 Kumar Kartikeya Dwivedi 2022-11-18  8258  					return ret;
00b85860feb809 Kumar Kartikeya Dwivedi 2022-11-18  8259  			}
00b85860feb809 Kumar Kartikeya Dwivedi 2022-11-18  8260  			continue;
00b85860feb809 Kumar Kartikeya Dwivedi 2022-11-18  8261  		}
00b85860feb809 Kumar Kartikeya Dwivedi 2022-11-18  8262  
00b85860feb809 Kumar Kartikeya Dwivedi 2022-11-18  8263  		if (!btf_type_is_ptr(t)) {
00b85860feb809 Kumar Kartikeya Dwivedi 2022-11-18  8264  			verbose(env, "Unrecognized arg#%d type %s\n", i, btf_type_str(t));
00b85860feb809 Kumar Kartikeya Dwivedi 2022-11-18  8265  			return -EINVAL;
00b85860feb809 Kumar Kartikeya Dwivedi 2022-11-18  8266  		}
00b85860feb809 Kumar Kartikeya Dwivedi 2022-11-18  8267  
00b85860feb809 Kumar Kartikeya Dwivedi 2022-11-18  8268  		if (reg->ref_obj_id) {
00b85860feb809 Kumar Kartikeya Dwivedi 2022-11-18  8269  			if (is_kfunc_release(meta) && meta->ref_obj_id) {
00b85860feb809 Kumar Kartikeya Dwivedi 2022-11-18  8270  				verbose(env, "verifier internal error: more than one arg with ref_obj_id R%d %u %u\n",
00b85860feb809 Kumar Kartikeya Dwivedi 2022-11-18  8271  					regno, reg->ref_obj_id,
00b85860feb809 Kumar Kartikeya Dwivedi 2022-11-18  8272  					meta->ref_obj_id);
00b85860feb809 Kumar Kartikeya Dwivedi 2022-11-18  8273  				return -EFAULT;
00b85860feb809 Kumar Kartikeya Dwivedi 2022-11-18  8274  			}
00b85860feb809 Kumar Kartikeya Dwivedi 2022-11-18  8275  			meta->ref_obj_id = reg->ref_obj_id;
00b85860feb809 Kumar Kartikeya Dwivedi 2022-11-18  8276  			if (is_kfunc_release(meta))
00b85860feb809 Kumar Kartikeya Dwivedi 2022-11-18  8277  				meta->release_regno = regno;
00b85860feb809 Kumar Kartikeya Dwivedi 2022-11-18  8278  		}
00b85860feb809 Kumar Kartikeya Dwivedi 2022-11-18  8279  
00b85860feb809 Kumar Kartikeya Dwivedi 2022-11-18  8280  		ref_t = btf_type_skip_modifiers(btf, t->type, &ref_id);
00b85860feb809 Kumar Kartikeya Dwivedi 2022-11-18  8281  		ref_tname = btf_name_by_offset(btf, ref_t->name_off);
00b85860feb809 Kumar Kartikeya Dwivedi 2022-11-18  8282  
00b85860feb809 Kumar Kartikeya Dwivedi 2022-11-18  8283  		kf_arg_type = get_kfunc_ptr_arg_type(env, meta, t, ref_t, ref_tname, args, i, nargs);
00b85860feb809 Kumar Kartikeya Dwivedi 2022-11-18  8284  		if (kf_arg_type < 0)
00b85860feb809 Kumar Kartikeya Dwivedi 2022-11-18  8285  			return kf_arg_type;
00b85860feb809 Kumar Kartikeya Dwivedi 2022-11-18  8286  
00b85860feb809 Kumar Kartikeya Dwivedi 2022-11-18  8287  		switch (kf_arg_type) {
00b85860feb809 Kumar Kartikeya Dwivedi 2022-11-18  8288  		case KF_ARG_PTR_TO_BTF_ID:
00b85860feb809 Kumar Kartikeya Dwivedi 2022-11-18  8289  			if (!is_kfunc_trusted_args(meta))
00b85860feb809 Kumar Kartikeya Dwivedi 2022-11-18  8290  				break;
00b85860feb809 Kumar Kartikeya Dwivedi 2022-11-18  8291  			if (!reg->ref_obj_id) {
00b85860feb809 Kumar Kartikeya Dwivedi 2022-11-18  8292  				verbose(env, "R%d must be referenced\n", regno);
00b85860feb809 Kumar Kartikeya Dwivedi 2022-11-18  8293  				return -EINVAL;
00b85860feb809 Kumar Kartikeya Dwivedi 2022-11-18  8294  			}
00b85860feb809 Kumar Kartikeya Dwivedi 2022-11-18  8295  			fallthrough;
00b85860feb809 Kumar Kartikeya Dwivedi 2022-11-18  8296  		case KF_ARG_PTR_TO_CTX:
00b85860feb809 Kumar Kartikeya Dwivedi 2022-11-18  8297  			/* Trusted arguments have the same offset checks as release arguments */
00b85860feb809 Kumar Kartikeya Dwivedi 2022-11-18  8298  			arg_type |= OBJ_RELEASE;
00b85860feb809 Kumar Kartikeya Dwivedi 2022-11-18  8299  			break;
00b85860feb809 Kumar Kartikeya Dwivedi 2022-11-18  8300  		case KF_ARG_PTR_TO_KPTR:
00b85860feb809 Kumar Kartikeya Dwivedi 2022-11-18  8301  		case KF_ARG_PTR_TO_DYNPTR:
00b85860feb809 Kumar Kartikeya Dwivedi 2022-11-18  8302  		case KF_ARG_PTR_TO_MEM:
00b85860feb809 Kumar Kartikeya Dwivedi 2022-11-18  8303  		case KF_ARG_PTR_TO_MEM_SIZE:
00b85860feb809 Kumar Kartikeya Dwivedi 2022-11-18  8304  			/* Trusted by default */
00b85860feb809 Kumar Kartikeya Dwivedi 2022-11-18  8305  			break;
00b85860feb809 Kumar Kartikeya Dwivedi 2022-11-18  8306  		default:
00b85860feb809 Kumar Kartikeya Dwivedi 2022-11-18  8307  			WARN_ON_ONCE(1);
00b85860feb809 Kumar Kartikeya Dwivedi 2022-11-18  8308  			return -EFAULT;
00b85860feb809 Kumar Kartikeya Dwivedi 2022-11-18  8309  		}
00b85860feb809 Kumar Kartikeya Dwivedi 2022-11-18  8310  
00b85860feb809 Kumar Kartikeya Dwivedi 2022-11-18  8311  		if (is_kfunc_release(meta) && reg->ref_obj_id)
00b85860feb809 Kumar Kartikeya Dwivedi 2022-11-18  8312  			arg_type |= OBJ_RELEASE;
00b85860feb809 Kumar Kartikeya Dwivedi 2022-11-18  8313  		ret = check_func_arg_reg_off(env, reg, regno, arg_type);
00b85860feb809 Kumar Kartikeya Dwivedi 2022-11-18  8314  		if (ret < 0)
00b85860feb809 Kumar Kartikeya Dwivedi 2022-11-18  8315  			return ret;
00b85860feb809 Kumar Kartikeya Dwivedi 2022-11-18  8316  
00b85860feb809 Kumar Kartikeya Dwivedi 2022-11-18  8317  		switch (kf_arg_type) {
00b85860feb809 Kumar Kartikeya Dwivedi 2022-11-18  8318  		case KF_ARG_PTR_TO_CTX:
00b85860feb809 Kumar Kartikeya Dwivedi 2022-11-18  8319  			if (reg->type != PTR_TO_CTX) {
00b85860feb809 Kumar Kartikeya Dwivedi 2022-11-18  8320  				verbose(env, "arg#%d expected pointer to ctx, but got %s\n", i, btf_type_str(t));
00b85860feb809 Kumar Kartikeya Dwivedi 2022-11-18  8321  				return -EINVAL;
00b85860feb809 Kumar Kartikeya Dwivedi 2022-11-18  8322  			}
00b85860feb809 Kumar Kartikeya Dwivedi 2022-11-18  8323  			break;
00b85860feb809 Kumar Kartikeya Dwivedi 2022-11-18  8324  		case KF_ARG_PTR_TO_KPTR:
00b85860feb809 Kumar Kartikeya Dwivedi 2022-11-18  8325  			if (reg->type != PTR_TO_MAP_VALUE) {
00b85860feb809 Kumar Kartikeya Dwivedi 2022-11-18  8326  				verbose(env, "arg#0 expected pointer to map value\n");
00b85860feb809 Kumar Kartikeya Dwivedi 2022-11-18  8327  				return -EINVAL;
00b85860feb809 Kumar Kartikeya Dwivedi 2022-11-18  8328  			}
00b85860feb809 Kumar Kartikeya Dwivedi 2022-11-18  8329  			ret = process_kf_arg_ptr_to_kptr(env, reg, ref_t, ref_tname, meta, i);
00b85860feb809 Kumar Kartikeya Dwivedi 2022-11-18  8330  			if (ret < 0)
00b85860feb809 Kumar Kartikeya Dwivedi 2022-11-18  8331  				return ret;
00b85860feb809 Kumar Kartikeya Dwivedi 2022-11-18  8332  			break;
00b85860feb809 Kumar Kartikeya Dwivedi 2022-11-18  8333  		case KF_ARG_PTR_TO_DYNPTR:
00b85860feb809 Kumar Kartikeya Dwivedi 2022-11-18  8334  			if (reg->type != PTR_TO_STACK) {
00b85860feb809 Kumar Kartikeya Dwivedi 2022-11-18  8335  				verbose(env, "arg#%d expected pointer to stack\n", i);
00b85860feb809 Kumar Kartikeya Dwivedi 2022-11-18  8336  				return -EINVAL;
00b85860feb809 Kumar Kartikeya Dwivedi 2022-11-18  8337  			}
00b85860feb809 Kumar Kartikeya Dwivedi 2022-11-18  8338  
00b85860feb809 Kumar Kartikeya Dwivedi 2022-11-18  8339  			if (!is_dynptr_reg_valid_init(env, reg)) {
00b85860feb809 Kumar Kartikeya Dwivedi 2022-11-18  8340  				verbose(env, "arg#%d pointer type %s %s must be valid and initialized\n",
00b85860feb809 Kumar Kartikeya Dwivedi 2022-11-18  8341  					i, btf_type_str(ref_t), ref_tname);
00b85860feb809 Kumar Kartikeya Dwivedi 2022-11-18  8342  				return -EINVAL;
00b85860feb809 Kumar Kartikeya Dwivedi 2022-11-18  8343  			}
00b85860feb809 Kumar Kartikeya Dwivedi 2022-11-18  8344  
00b85860feb809 Kumar Kartikeya Dwivedi 2022-11-18  8345  			if (!is_dynptr_type_expected(env, reg, ARG_PTR_TO_DYNPTR | DYNPTR_TYPE_LOCAL)) {
00b85860feb809 Kumar Kartikeya Dwivedi 2022-11-18  8346  				verbose(env, "arg#%d pointer type %s %s points to unsupported dynamic pointer type\n",
00b85860feb809 Kumar Kartikeya Dwivedi 2022-11-18  8347  					i, btf_type_str(ref_t), ref_tname);
00b85860feb809 Kumar Kartikeya Dwivedi 2022-11-18  8348  				return -EINVAL;
00b85860feb809 Kumar Kartikeya Dwivedi 2022-11-18  8349  			}
00b85860feb809 Kumar Kartikeya Dwivedi 2022-11-18  8350  			break;
00b85860feb809 Kumar Kartikeya Dwivedi 2022-11-18  8351  		case KF_ARG_PTR_TO_BTF_ID:
00b85860feb809 Kumar Kartikeya Dwivedi 2022-11-18  8352  			/* Only base_type is checked, further checks are done here */
00b85860feb809 Kumar Kartikeya Dwivedi 2022-11-18  8353  			if (reg->type != PTR_TO_BTF_ID &&
00b85860feb809 Kumar Kartikeya Dwivedi 2022-11-18  8354  			    (!reg2btf_ids[base_type(reg->type)] || type_flag(reg->type))) {
00b85860feb809 Kumar Kartikeya Dwivedi 2022-11-18  8355  				verbose(env, "arg#%d expected pointer to btf or socket\n", i);
00b85860feb809 Kumar Kartikeya Dwivedi 2022-11-18  8356  				return -EINVAL;
00b85860feb809 Kumar Kartikeya Dwivedi 2022-11-18  8357  			}
00b85860feb809 Kumar Kartikeya Dwivedi 2022-11-18  8358  			ret = process_kf_arg_ptr_to_btf_id(env, reg, ref_t, ref_tname, ref_id, meta, i);
00b85860feb809 Kumar Kartikeya Dwivedi 2022-11-18  8359  			if (ret < 0)
00b85860feb809 Kumar Kartikeya Dwivedi 2022-11-18  8360  				return ret;
00b85860feb809 Kumar Kartikeya Dwivedi 2022-11-18  8361  			break;
00b85860feb809 Kumar Kartikeya Dwivedi 2022-11-18  8362  		case KF_ARG_PTR_TO_MEM:
00b85860feb809 Kumar Kartikeya Dwivedi 2022-11-18  8363  			resolve_ret = btf_resolve_size(btf, ref_t, &type_size);
00b85860feb809 Kumar Kartikeya Dwivedi 2022-11-18  8364  			if (IS_ERR(resolve_ret)) {
00b85860feb809 Kumar Kartikeya Dwivedi 2022-11-18  8365  				verbose(env, "arg#%d reference type('%s %s') size cannot be determined: %ld\n",
00b85860feb809 Kumar Kartikeya Dwivedi 2022-11-18  8366  					i, btf_type_str(ref_t), ref_tname, PTR_ERR(resolve_ret));
00b85860feb809 Kumar Kartikeya Dwivedi 2022-11-18  8367  				return -EINVAL;
00b85860feb809 Kumar Kartikeya Dwivedi 2022-11-18  8368  			}
00b85860feb809 Kumar Kartikeya Dwivedi 2022-11-18  8369  			ret = check_mem_reg(env, reg, regno, type_size);
00b85860feb809 Kumar Kartikeya Dwivedi 2022-11-18  8370  			if (ret < 0)
00b85860feb809 Kumar Kartikeya Dwivedi 2022-11-18  8371  				return ret;
00b85860feb809 Kumar Kartikeya Dwivedi 2022-11-18  8372  			break;
00b85860feb809 Kumar Kartikeya Dwivedi 2022-11-18  8373  		case KF_ARG_PTR_TO_MEM_SIZE:
00b85860feb809 Kumar Kartikeya Dwivedi 2022-11-18  8374  			ret = check_kfunc_mem_size_reg(env, &regs[regno + 1], regno + 1);
00b85860feb809 Kumar Kartikeya Dwivedi 2022-11-18  8375  			if (ret < 0) {
00b85860feb809 Kumar Kartikeya Dwivedi 2022-11-18  8376  				verbose(env, "arg#%d arg#%d memory, len pair leads to invalid memory access\n", i, i + 1);
00b85860feb809 Kumar Kartikeya Dwivedi 2022-11-18  8377  				return ret;
00b85860feb809 Kumar Kartikeya Dwivedi 2022-11-18  8378  			}
00b85860feb809 Kumar Kartikeya Dwivedi 2022-11-18  8379  			/* Skip next '__sz' argument */
00b85860feb809 Kumar Kartikeya Dwivedi 2022-11-18  8380  			i++;
00b85860feb809 Kumar Kartikeya Dwivedi 2022-11-18  8381  			break;
00b85860feb809 Kumar Kartikeya Dwivedi 2022-11-18  8382  		}
00b85860feb809 Kumar Kartikeya Dwivedi 2022-11-18  8383  	}
00b85860feb809 Kumar Kartikeya Dwivedi 2022-11-18  8384  
00b85860feb809 Kumar Kartikeya Dwivedi 2022-11-18  8385  	if (is_kfunc_release(meta) && !meta->release_regno) {
00b85860feb809 Kumar Kartikeya Dwivedi 2022-11-18  8386  		verbose(env, "release kernel function %s expects refcounted PTR_TO_BTF_ID\n",
00b85860feb809 Kumar Kartikeya Dwivedi 2022-11-18  8387  			func_name);
00b85860feb809 Kumar Kartikeya Dwivedi 2022-11-18  8388  		return -EINVAL;
00b85860feb809 Kumar Kartikeya Dwivedi 2022-11-18  8389  	}
00b85860feb809 Kumar Kartikeya Dwivedi 2022-11-18  8390  
00b85860feb809 Kumar Kartikeya Dwivedi 2022-11-18  8391  	return 0;
00b85860feb809 Kumar Kartikeya Dwivedi 2022-11-18  8392  }
00b85860feb809 Kumar Kartikeya Dwivedi 2022-11-18  8393  

:::::: The code at line 8189 was first introduced by commit
:::::: 00b85860feb809852af9a88cb4ca8766d7dff6a3 bpf: Rewrite kfunc argument handling

:::::: TO: Kumar Kartikeya Dwivedi <memxor@gmail.com>
:::::: CC: Alexei Starovoitov <ast@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
